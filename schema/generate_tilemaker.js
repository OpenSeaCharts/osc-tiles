import { compile, NodeHost } from "@typespec/compiler";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { getOsmTags, getOsmSources } from "./osm.js";

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
        
        // Get sources from @osmSource
        let sources = getOsmSources(program, type) || [];
        
        // Fallback to @doc "Sources: " for backward compatibility if needed, or just remove it.
        // The user asked to replace it, so we rely on @osmSource.
        if (sources.length === 0) {
             for (const d of type.decorators) {
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
                    const osmTags = getOsmTags(program, prop);
                    attributes.push({
                        name: propName,
                        osmTags: osmTags
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
    luaLines.push('dofile("helpers.lua")');
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

            // Define emit function for all models
            luaLines.push(`            local function emit(prefix)`);
            
            // Special handling for Light model to split by colour
            if (m.name === "light") {
                luaLines.push(`                local colours = Find(prefix .. ":colour")`);
                luaLines.push(`                if colours ~= "" and string.find(colours, ";") then`);
                luaLines.push(`                    local colour_list = split(colours, ";")`);
                luaLines.push(`                    for _, c in ipairs(colour_list) do`);
                luaLines.push(`                        Layer("${layerName}", is_area)`);
                luaLines.push(`                        Attribute("type", "${sourceType}")`);
                luaLines.push(`                        Attribute("id", Id())`);
                
                for (const attrObj of baseAttrs) {
                    const attrName = attrObj.name;
                    if (attrName === "id") continue;
                    if (attrName === "colour") {
                         luaLines.push(`                        Attribute("colour", c)`);
                         continue;
                    }
                    
                    let tagExpr;
                    if (attrObj.osmTags && attrObj.osmTags.length > 0) {
                        // If multiple tags, we use the first one for now, or we could implement coalescing
                        // For now, let's assume the first one is primary or they are alternatives
                        // If we want to support multiple lookups, we need a helper function in Lua or complex expression
                        // Let's implement a Coalesce-like logic if multiple tags are present
                        
                        const exprs = attrObj.osmTags.map(tag => {
                             if (tag === "seamark:name") {
                                 return `"seamark:name"`;
                             } else if (tag.startsWith(`seamark:${sourceType}:`)) {
                                 return `prefix .. "${tag.substring(8 + sourceType.length)}"`;
                             } else {
                                 return `"${tag}"`;
                             }
                        });
                        
                        if (exprs.length === 1) {
                            tagExpr = exprs[0];
                        } else {
                            // Generate a chain of (Find(a) ~= "" and Find(a)) or (Find(b) ~= "" and Find(b)) ...
                            // Or better: define a helper Coalesce(tags...)
                            // But we can't easily pass variable args to Find.
                            // Let's just use the first one for now as the primary mapping, 
                            // OR if the user intention is to group different things, maybe they want to check all?
                            // "Buoy category is a group of different buoys" -> maybe they mean the attribute is present in one of these tags.
                            
                            // Let's generate a Lua expression that tries them in order.
                            // (Find(a) ~= "" and Find(a)) or Find(b)
                            // Actually Find returns "" if not found.
                            // So we want: Find(a) ~= "" and Find(a) or Find(b)
                            // Lua 'or' returns the first truthy value. But "" is truthy in Lua!
                            // So we need a helper: FirstNotEmpty(list)
                            
                            // Let's assume for now we pick the first one, unless I add a helper to Lua.
                            // Adding helper to Lua is easy since I have helpers.lua.
                            
                            // Let's use a custom logic here:
                            // Find(a) ~= "" and Find(a) or (Find(b) ~= "" and Find(b) or "")
                            
                            let luaExpr = `""`;
                            for (let i = exprs.length - 1; i >= 0; i--) {
                                luaExpr = `(Find(${exprs[i]}) ~= "" and Find(${exprs[i]}) or ${luaExpr})`;
                            }
                            tagExpr = luaExpr;
                        }
                    } else {
                        const snakeAttrName = attrObj.name.replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase();
                        tagExpr = `prefix .. ":${snakeAttrName}"`;
                    }
                    luaLines.push(`                        Attribute("${attrName}", ${tagExpr.startsWith('(') ? tagExpr : `Find(${tagExpr})`})`);
                }
                luaLines.push(`                    end`);
                luaLines.push(`                else`);
            }

            // Standard emit logic (used for non-light models or light models without semicolon colours)
            luaLines.push(`                Layer("${layerName}", is_area)`);
            luaLines.push(`                Attribute("type", "${sourceType}")`);
            luaLines.push(`                Attribute("id", Id())`);
            
            for (const attrObj of baseAttrs) {
                const attrName = attrObj.name;
                if (attrName === "id") continue;
                
                if (attrName === "function" && !attrObj.osmTag) {
                    luaLines.push(`                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))`);
                    continue;
                }

                let tagExpr;
                if (attrObj.osmTags && attrObj.osmTags.length > 0) {
                    const exprs = attrObj.osmTags.map(tag => {
                            if (tag === "seamark:name") {
                                return `"seamark:name"`;
                            } else if (tag.startsWith(`seamark:${sourceType}:`)) {
                                return `prefix .. "${tag.substring(8 + sourceType.length)}"`;
                            } else {
                                return `"${tag}"`;
                            }
                    });
                    
                    if (exprs.length === 1) {
                        tagExpr = `Find(${exprs[0]})`;
                    } else {
                        let luaExpr = `""`;
                        for (let i = exprs.length - 1; i >= 0; i--) {
                            luaExpr = `(Find(${exprs[i]}) ~= "" and Find(${exprs[i]}) or ${luaExpr})`;
                        }
                        tagExpr = luaExpr;
                    }
                } else {
                    const snakeAttrName = attrObj.name.replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase();
                    tagExpr = `Find(prefix .. ":${snakeAttrName}")`;
                }
                luaLines.push(`                Attribute("${attrName}", ${tagExpr})`);
            }

            if (m.name === "light") {
                luaLines.push(`                end`); // End of else block for light colour split
            }
            
            luaLines.push(`            end`); // End of emit function

            // Call emit for main object
            luaLines.push(`            emit("seamark:${sourceType}")`);

            // Loop for indexed objects
            luaLines.push(`            for i=1,25 do`);
            luaLines.push(`                local p = "seamark:${sourceType}:" .. i`);
            
            // Check if any relevant attribute exists for this index
            const checkConditions = [];
            // We check the first 5 attributes to avoid huge if statements, or specific ones if known
            // For robustness, let's check attributes that are likely to be present.
            // If the model has 'category', 'function', 'colour', 'character', 'range', 'info'
            const commonAttrs = ['category', 'function', 'colour', 'character', 'range', 'info', 'system', 'impact', 'reference'];
            
            let hasChecks = false;
            for (const attrObj of baseAttrs) {
                const attrName = attrObj.name;
                if (commonAttrs.includes(attrName) || baseAttrs.length < 5) {
                     let suffix;
                     // We only check the first tag if multiple are present for existence check
                     // This is an approximation.
                     if (attrObj.osmTags && attrObj.osmTags.length > 0) {
                         const firstTag = attrObj.osmTags[0];
                         if (firstTag.startsWith(`seamark:${sourceType}:`)) {
                             suffix = firstTag.substring(8 + sourceType.length);
                         } else {
                             // If it's a completely different tag, we can't easily check it with 'p' prefix
                             // unless we assume the structure holds.
                             // For indexed tags, usually the structure is seamark:type:index:attribute
                             // So if osmTag is "seamark:foo:bar", indexed is "seamark:foo:1:bar" ??
                             // Or "seamark:type:1:bar" ?
                             // The current logic assumes `p` is "seamark:type:i"
                             // And we append suffix.
                             // If osmTag is custom, we might not be able to use it for indexed check easily
                             // unless it follows the pattern.
                             // Let's skip custom tags for indexed check for now unless they match pattern.
                             if (firstTag.includes(":")) {
                                 const parts = firstTag.split(":");
                                 suffix = ":" + parts[parts.length - 1];
                             } else {
                                 suffix = ":" + firstTag;
                             }
                         }
                     } else {
                         suffix = ":" + attrObj.name.replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase();
                     }
                     checkConditions.push(`Find(p .. "${suffix}") ~= ""`);
                     hasChecks = true;
                }
            }
            
            if (!hasChecks && baseAttrs.length > 0) {
                // Fallback: check the first attribute if no common ones found
                 let suffix;
                 const attrObj = baseAttrs[0];
                 if (attrObj.osmTags && attrObj.osmTags.length > 0) {
                     const firstTag = attrObj.osmTags[0];
                     if (firstTag.startsWith(`seamark:${sourceType}:`)) {
                         suffix = firstTag.substring(8 + sourceType.length);
                     } else {
                         if (firstTag.includes(":")) {
                             const parts = firstTag.split(":");
                             suffix = ":" + parts[parts.length - 1];
                         } else {
                             suffix = ":" + firstTag;
                         }
                     }
                 } else {
                     suffix = ":" + attrObj.name.replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase();
                 }
                 checkConditions.push(`Find(p .. "${suffix}") ~= ""`);
            }

            if (checkConditions.length > 0) {
                luaLines.push(`                if ${checkConditions.join(' or ')} then`);
                luaLines.push(`                    emit(p)`);
                luaLines.push(`                end`);
            }
            luaLines.push(`            end`);
            
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

    fs.writeFileSync(path.resolve(__dirname, "../tilemaker/process.lua"), luaLines.join('\n'));
    console.log("Updated ../tilemaker/process.lua");
}

main().catch(err => {
    console.error(err);
    process.exit(1);
});
