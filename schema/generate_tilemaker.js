import { compile, NodeHost } from "@typespec/compiler";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { getOsmTag } from "./osm.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

async function main() {
    const mainFile = path.resolve(__dirname, "main.tsp");
    const program = await compile(NodeHost, mainFile, {
        noEmit: true,
    });

    if (program.diagnostics.length > 0) {
        const errors = program.diagnostics.filter(d => d.severity === "error");
        if (errors.length > 0) {
            console.error("TypeSpec compilation errors:", errors);
            process.exit(1);
        }
    }

    const globalNs = program.checker.getGlobalNamespaceType();
    const seamarksNs = globalNs.namespaces.get("OpenSeaCharts");
    
    if (!seamarksNs) {
        console.error("Namespace 'OpenSeaCharts' not found");
        console.log("Available namespaces:", Array.from(globalNs.namespaces.keys()));
        process.exit(1);
    }

    console.log("Found OpenSeaCharts namespace with", seamarksNs.models.size, "models");

    const models = [];
    
    for (const [name, type] of seamarksNs.models) {
        if (["Layer", "SeamarkObject", "Node", "Way", "Area", "Point", "Line", "Polygon"].includes(name)) continue;
        
        // Get sources from @doc
        let sources = [];
        
        for (const d of type.decorators) {
            console.log(`Decorator: ${d.decorator.name}`);
            if (d.decorator.name === "$doc" && d.args.length > 0) {
                let docStr = "";
                if (d.args[0].value && typeof d.args[0].value === 'object' && 'value' in d.args[0].value) {
                     docStr = String(d.args[0].value.value);
                } else {
                     docStr = String(d.args[0].value);
                }
                
                if (docStr.startsWith("Sources: ")) {
                    sources = docStr.substring(9).split(", ").map(s => s.trim());
                }
            }
        }

        // Get properties
        const attributes = [];
        let geometries = [];
        const processedProps = new Set();

        let currentType = type;
        while (currentType) {
            for (const [propName, prop] of currentType.properties) {
                if (processedProps.has(propName)) continue;
                processedProps.add(propName);

                if (propName === "geometryType") {
                    // Only process geometryType from the leaf model (or first encountered)
                    // But wait, Anchorage has geometryType. Seamark doesn't.
                    // If Seamark had it, we might want to override?
                    // For now, just process it.
                    console.log(`Model ${name} (from ${currentType.name}) geometryType kind: ${prop.type.kind}`);
                    if (prop.type.kind === "String") {
                        geometries.push(prop.type.value);
                    } else if (prop.type.kind === "EnumMember") {
                        geometries.push(prop.type.value);
                    } else if (prop.type.kind === "Union") {
                        for (const variant of prop.type.variants.values()) {
                            let type = variant.type;
                            if (type.kind === "ModelProperty") {
                                type = type.type;
                            }
    
                            console.log(`  Variant resolved kind: ${type.kind}`);
                            if (type.kind === "String") {
                                geometries.push(type.value);
                            } else if (type.kind === "EnumMember") {
                                geometries.push(type.value);
                            }
                        }
                    } else if (prop.type.kind === "Tuple") {
                        for (const val of prop.type.values) {
                            console.log(`  Tuple value kind: ${val.kind}`);
                            if (val.kind === "String") {
                                geometries.push(val.value);
                            } else if (val.kind === "EnumMember") {
                                geometries.push(val.value);
                            }
                        }
                    }
                } else {
                    const osmTag = getOsmTag(program, prop);
                    attributes.push({
                        name: propName,
                        osmTag: osmTag
                    });
                }
            }
            currentType = currentType.baseModel;
        }
        
        if (sources.length === 0) {
             console.warn("Warning: No sources found for model", name);
        }
        
        if (geometries.length === 0) {
            console.warn("Warning: No geometryType found for model", name);
            // Default to node if unknown
            geometries.push("node");
        }

        const tagName = name.replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase();
        const layerName = tagName.startsWith('_') ? tagName.substring(1) : tagName;

        models.push({
            name: layerName,
            geometries,
            attributes,
            sources
        });
    }

    // Generate config.json
    const config = {
        layers: {},
        settings: {
            minzoom: 8,
            maxzoom: 12,
            basezoom: 13,
            include_ids: false,
            combine_below: 0,
            name: "OpenSeaCharts",
            version: "0.1.0-wip",
            description: "OpenSeaCharts Tiles",
            compress: "gzip",
            filemetadata: {
                tilejson: "3.0.0"
            }
        }
    };

    for (const m of models) {
        config.layers[m.name] = { minzoom: 8, maxzoom: 12 };
    }

    fs.writeFileSync(path.resolve(__dirname, "../tilemaker/config.json"), JSON.stringify(config, null, 2));
    console.log("Updated ../tilemaker/config.json");

    // Generate process.lua
    const luaLines = [];
    luaLines.push('function init_function(name) end');
    luaLines.push('function exit_function() end');
    luaLines.push('node_keys = { "seamark:type" }');
    luaLines.push('way_keys = { "seamark:type" }');
    luaLines.push('');
    luaLines.push('function split(string, delimiter)');
    luaLines.push('    local fields = {}');
    luaLines.push('    for field in string:gmatch("([^" .. delimiter .. "]+)") do');
    luaLines.push('        fields[#fields + 1] = field');
    luaLines.push('    end');
    luaLines.push('    return fields');
    luaLines.push('end');
    luaLines.push('');
    luaLines.push('function process_seamark(is_way, is_closed)');
    luaLines.push('    local type = Find("seamark:type")');
    luaLines.push('    if type == "" then return end');
    luaLines.push('    type = string.lower(type)');
    luaLines.push('    type = string.gsub(type, " ", "_")');
    luaLines.push('');
    luaLines.push('    local handlers = {');

    for (const m of models) {
        const layerName = m.name;
        const supportsNode = m.geometries.includes('node');
        const supportsWay = m.geometries.includes('way');
        const supportsArea = m.geometries.includes('area');
        
        for (const sourceType of m.sources) {
            luaLines.push(`        ["${sourceType}"] = function()`);
            
            // Logic to determine if we should output a layer
            luaLines.push(`            local output = false`);
            luaLines.push(`            local is_area = false`);
            
            luaLines.push(`            if is_way then`);
            if (supportsArea) {
                luaLines.push(`                if is_closed or Find("area") == "yes" then`);
                luaLines.push(`                    output = true`);
                luaLines.push(`                    is_area = true`);
                luaLines.push(`                end`);
            }
            if (supportsWay) {
                if (supportsArea) {
                    luaLines.push(`                if not output then`); // If not already area
                    luaLines.push(`                    output = true`);
                    luaLines.push(`                    is_area = false`);
                    luaLines.push(`                end`);
                } else {
                    luaLines.push(`                output = true`);
                    luaLines.push(`                is_area = false`);
                }
            }
            luaLines.push(`            else`); // Node
            if (supportsNode) {
                luaLines.push(`                output = true`);
                luaLines.push(`                is_area = false`);
            }
            luaLines.push(`            end`);
            
            luaLines.push(`            if output then`);
            
            const baseAttrs = [];
            const numberedAttrs = {}; 
            
            for (const attrObj of m.attributes) {
                baseAttrs.push(attrObj);
            }

            // Special handling for Light model to split by colour
            if (m.name === "light") {
                luaLines.push(`                local colours = Find("seamark:light:colour")`);
                luaLines.push(`                if colours ~= "" and string.find(colours, ";") then`);
                luaLines.push(`                    local colour_list = split(colours, ";")`);
                luaLines.push(`                    for _, c in ipairs(colour_list) do`);
                luaLines.push(`                        Layer("${layerName}", is_area)`);
                luaLines.push(`                        Attribute("type", "${sourceType}")`);
                luaLines.push(`                        Attribute("id", Id())`);
                
                for (const attrObj of baseAttrs) {
                    const attrName = attrObj.name;
                    if (attrName === "id") continue; // Already added
                    if (attrName === "colour") {
                         luaLines.push(`                        Attribute("colour", c)`);
                         continue;
                    }
                    const snakeAttrName = attrName.replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase();
                    const tagToFind = attrObj.osmTag ? attrObj.osmTag : `seamark:${sourceType}:${snakeAttrName}`;
                    luaLines.push(`                        Attribute("${attrName}", Find("${tagToFind}"))`);
                }
                luaLines.push(`                    end`);
                luaLines.push(`                else`);
            }

            luaLines.push(`                Layer("${layerName}", is_area)`);
            luaLines.push(`                Attribute("type", "${sourceType}")`);
            luaLines.push(`                Attribute("id", Id())`);
            
            for (const attrObj of baseAttrs) {
                const attrName = attrObj.name;
                if (attrName === "id") continue; // Already added
                
                if (attrName === "function" && !attrObj.osmTag) {
                    // Only derive function if it doesn't have an explicit OSM tag
                    // This handles Beacon and Buoy which derive function from type
                    // But Building has an explicit seamark:building:function tag
                    luaLines.push(`                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))`);
                    continue;
                }

                const snakeAttrName = attrName.replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase();
                const tagToFind = attrObj.osmTag ? attrObj.osmTag : `seamark:${sourceType}:${snakeAttrName}`;
                luaLines.push(`                Attribute("${attrName}", Find("${tagToFind}"))`);
            }

            if (m.name === "light") {
                luaLines.push(`                end`); // End of else block
            }
            // Manual name attribute removed as it should be in the model now

            /* Numbered attributes logic disabled for now as we use property names
            for (const idx of Object.keys(numberedAttrs).sort((a,b) => a-b)) {
                const attrs = numberedAttrs[idx];
                const conditions = attrs.map(a => `Find("seamark:${sourceType}:${a.fullAttr}") ~= ""`).join(' or ');
                
                luaLines.push(`                if ${conditions} then`);
                luaLines.push(`                    Layer("${layerName}", is_area)`);
                luaLines.push(`                    Attribute("type", "${sourceType}")`);
                for (const a of attrs) {
                    const attrName = a.suffix.replace(/:/g, '_');
                    luaLines.push(`                    Attribute("${attrName}", Find("seamark:${sourceType}:${a.fullAttr}"))`);
                }
                luaLines.push(`                    Attribute("name", Find("seamark:name"))`);
                luaLines.push(`                end`);
            }
            */
            
            luaLines.push(`            end`); // end if output
            luaLines.push(`        end,`);
        }
    }

    luaLines.push('    }');
    luaLines.push('');
    luaLines.push('    if handlers[type] then');
    luaLines.push('        handlers[type]()');
    luaLines.push('    end');
    luaLines.push('end');
    luaLines.push('');
    luaLines.push('function node_function() process_seamark(false, false) end');
    luaLines.push('function way_function() process_seamark(true, IsClosed()) end');

    fs.writeFileSync(path.resolve(__dirname, "../tilemaker/process.lua"), luaLines.join('\n'));
    console.log("Updated ../tilemaker/process.lua");
}

main().catch(err => {
    console.error(err);
    process.exit(1);
});
