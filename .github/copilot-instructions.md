# Project Overview: osc-tiles

This project generates vector tiles for OpenSeaMap seamarks using `tilemaker`.

## Directory Structure

- **osm/**: Contains raw OSM data and scripts to manage it.
  - `create.sh`: Downloads planet data, extracts seamarks, and creates `seamarks.osm.pbf`.
  - `update.sh`: Updates existing `seamarks.osm.pbf` with latest changes.
  - `seamarks.osm.pbf`: The input data for tile generation.

- **tags/**: Contains scripts for analyzing seamark tags and the generated CSVs.
  - `aggregate_tags.py`: Python script to analyze `../osm/seamarks.osm.pbf` and generate `seamark_tags.csv`.
  - `generate_tilemaker_config.py`: Python script that reads `seamark_tags.csv` and automatically updates `../tilemaker/config.json` and `../tilemaker/process.lua`.
  - `seamark_tags.csv`: Aggregated statistics of seamark tags.

- **tilemaker/**: Contains tile generation configuration and helper scripts.
  - `config.json`: Tilemaker configuration (layers, zoom levels).
  - `process.lua`: Lua script for processing OSM tags into vector tile layers.
  - `run.sh`: Runs `tilemaker` to generate `seamarks.mbtiles`.

## Workflow

1.  **Data Preparation**:
    - Run `osm/create.sh` (initial setup) or `osm/update.sh` (maintenance) to get the latest `osm/seamarks.osm.pbf`.

2.  **Tag Analysis**:
    - Run `python tags/aggregate_tags.py` to generate `tags/seamark_tags.csv`. This file lists all `seamark:*` tags and their values.

3.  **Configuration Update**:
    - Run `python tags/generate_tilemaker_config.py` to update `tilemaker/config.json` and `tilemaker/process.lua`.
    - This ensures that all seamark types found in the data are represented as layers in the vector tiles.
    - **Zoom Levels**: Seamark layers are configured for minzoom 8 and maxzoom 12.
    - **Filtering & Normalization**: The script filters tags using a whitelist of allowed prefixes/types and normalizes them (lowercase, spaces to underscores) to ensure clean layer names.
    - **TileJSON**: Updates the TileJSON version to 3.0.0 in `config.json`.

4. **Tile Generation**:
    - Run `tilemaker/run.sh` to generate `tilemaker/seamarks.mbtiles`.

## Key Configurations

- **Seamark Grouping**: Seamark types are grouped into layers (e.g., `buoy_lateral`, `buoy_cardinal` -> `buoy` layer).
- **Attributes**: All attributes found for a seamark type in the CSV are added to the tile features.
- **Geometry**: The `generate_tilemaker_config.py` script infers whether a feature should be a point, line, or polygon based on the seamark type name (e.g., types containing "area" are treated as polygons).
