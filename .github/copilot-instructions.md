# Project Overview: osc-tiles

This project generates vector tiles for OpenSeaMap seamarks using `tilemaker`.

## Directory Structure

- **osm/**: Contains raw OSM data and scripts to manage it.
  - `create.sh`: Downloads planet data, extracts seamarks, and creates `seamarks.osm.pbf`.
  - `update.sh`: Updates existing `seamarks.osm.pbf` with latest changes.
  - `seamarks.osm.pbf`: The input data for tile generation.

- **schema/**: Contains the TypeSpec schema and generators.
  - `main.tsp`: The TypeSpec definition of the seamark schema (Source of Truth).
  - `generate_tilemaker.js`: Generates `../tilemaker/process.lua` and `../tilemaker/config.json`.
  - `generate_docs.js`: Generates `../SCHEMA.md`.
  - `osm.js`: Helper for OSM tag mapping.

- **tags/**: Contains scripts for analyzing seamark tags.
  - `seamark_tags.csv`: Aggregated statistics of seamark tags.

- **tilemaker/**: Contains tile generation configuration and helper scripts.
  - `config.json`: Tilemaker configuration (layers, zoom levels) - Generated.
  - `process.lua`: Lua script for processing OSM tags into vector tile layers - Generated.
  - `run.sh`: Runs `tilemaker` to generate `seamarks.mbtiles`.

## Workflow

1.  **Data Preparation**:
    - Run `osm/create.sh` (initial setup) or `osm/update.sh` (maintenance) to get the latest `osm/seamarks.osm.pbf`.

2.  **Schema Definition**:
    - Edit `schema/main.tsp` to define new seamark types, attributes, or modify existing ones.
    - Use `@doc` decorators to document models and attributes.
    - Use `geometryType` property to specify if it's a Point, Line, Polygon, etc.

3.  **Configuration Generation**:
    - Run `npm run build` inside the `schema/` directory.
    - This executes:
        - `generate_tilemaker.js`: Updates `tilemaker/config.json` and `tilemaker/process.lua`.
        - `generate_docs.js`: Updates `SCHEMA.md`.

4. **Tile Generation**:
    - Run `tilemaker/run.sh` to generate `tilemaker/seamarks.mbtiles`.

## Key Configurations

- **TypeSpec Schema**: The `schema/main.tsp` file is the central definition. It defines:
    - **Models**: Each seamark type (e.g., `Buoy`, `Light`) is a model.
    - **Attributes**: Properties of the model map to vector tile attributes.
    - **OSM Mapping**: The generator infers OSM tags (e.g., `seamark:type`, `seamark:<type>:<attribute>`).
- **Generated Lua**: The `process.lua` script is automatically generated to:
    - Filter OSM objects based on `seamark:type`.
    - Extract attributes defined in the schema.
    - Handle special cases like splitting `light` features by colour.
    - Add a unique `id` to every feature.
