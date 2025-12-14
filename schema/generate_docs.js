import { compile, NodeHost } from "@typespec/compiler";
import fs from "fs";
import path from "path";
import { fileURLToPath } from "url";
import { getOsmTag } from "./osm.js";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

function getDoc(type) {
    let description = "";
    let sources = [];

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
            } else {
                description = docStr;
            }
        }
    }
    return { description, sources };
}

function getTypeName(type) {
    if (type.kind === "Scalar") return type.name;
    if (type.kind === "Enum") return type.name;
    if (type.kind === "Model") return type.name;
    if (type.kind === "Union") {
        return Array.from(type.variants.values()).map(v => getTypeName(v.type)).join(" | ");
    }
    if (type.kind === "Array") {
        return `${getTypeName(type.elementType)}[]`;
    }
    return type.kind;
}

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
        process.exit(1);
    }

    const models = [];
    
    for (const [name, type] of seamarksNs.models) {
        if (["Layer", "SeamarkObject", "Node", "Way", "Area", "Point", "Line", "Polygon"].includes(name)) continue;
        
        const { description: doc, sources } = getDoc(type);

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
                            if (type.kind === "String") {
                                geometries.push(type.value);
                            } else if (type.kind === "EnumMember") {
                                geometries.push(type.value);
                            }
                        }
                    } else if (prop.type.kind === "Tuple") {
                        for (const val of prop.type.values) {
                            if (val.kind === "String") {
                                geometries.push(val.value);
                            } else if (val.kind === "EnumMember") {
                                geometries.push(val.value);
                            }
                        }
                    }
                } else {
                    const osmTag = getOsmTag(program, prop);
                    const { description: propDoc } = getDoc(prop);
                    attributes.push({
                        name: propName,
                        type: getTypeName(prop.type),
                        osmTag: osmTag,
                        doc: propDoc
                    });
                }
            }
            currentType = currentType.baseModel;
        }

        models.push({
            name,
            doc,
            sources,
            geometries,
            attributes
        });
    }

    // Generate Markdown
    let md = "# OpenSeaCharts Schema Documentation\n\n";
    md += "This document describes the data model for OpenSeaCharts vector tiles.\n\n";

    for (const m of models) {
        md += `## ${m.name}\n\n`;
        if (m.doc) {
            md += `${m.doc}\n\n`;
        }
        
        md += `**Geometries:** ${m.geometries.join(", ")}\n\n`;
        md += `**Sources:** ${m.sources.join(", ")}\n\n`;
        
        md += `### Attributes\n\n`;
        md += `| Name | Type | OSM Tag | Description |\n`;
        md += `|------|------|---------|-------------|\n`;
        
        for (const attr of m.attributes) {
            let osmTagDisplay = "-";
            if (attr.osmTag) {
                osmTagDisplay = `\`${attr.osmTag}\``;
            } else if (attr.name === "function") {
                osmTagDisplay = "`seamark:type`";
            } else if (m.sources.length > 0) {
                 const snakeName = attr.name.replace(/([a-z])([A-Z])/g, '$1_$2').toLowerCase();
                 if (m.sources.length === 1) {
                     osmTagDisplay = `\`seamark:${m.sources[0]}:${snakeName}\``;
                 } else {
                     osmTagDisplay = `\`seamark:<source>:${snakeName}\``;
                 }
            }

            const typeDisplay = `\`${attr.type}\``;
            md += `| ${attr.name} | ${typeDisplay} | ${osmTagDisplay} | ${attr.doc} |\n`;
        }
        md += `\n`;
    }

    const docsPath = path.resolve(__dirname, "../SCHEMA.md");
    fs.writeFileSync(docsPath, md);
    console.log(`Documentation generated at ${docsPath}`);
}

main().catch(err => {
    console.error(err);
    process.exit(1);
});
