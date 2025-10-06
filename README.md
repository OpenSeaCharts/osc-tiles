# OpenSeaCharts Tiles

The scope of this repository is tile generation based on the OpenSeaCharts tile
schema.

> [!TIP]
> You can download generated `.osm.pbf`, `.mbtiles` and `.pmtiles` files:
> 
> - [seamarks.osm.pbf](https://pub-d2551c5d39b9474c8938b01fbba8c6ba.r2.dev/seamarks.osm.pbf)
> - [seamarks.mbtiles](https://pub-d2551c5d39b9474c8938b01fbba8c6ba.r2.dev/seamarks.mbtiles)
> - [seamarks.pmtiles](https://pub-d2551c5d39b9474c8938b01fbba8c6ba.r2.dev/seamarks.pmtiles)

![Raw tiles showcase](https://raw.githubusercontent.com/OpenSeaCharts/osc-tiles/4c6721b2e7ff96f0c5d8b70d7b8fd455160e90e8/tile-demo.jpg)

## Usage

There are different ways to use the vector tiles.

### PMTiles

[PMTiles](https://docs.protomaps.com/pmtiles/) is a relatively new concept where
no tile server is required. You can either download a pmtiles file and use it
locally or use it directly from a web server that supports HTTP range requests.
There is
an [online Style Editor with PMTiles support](https://editor.protomaps.com/)
available.

### MBTiles

You can download the generated MBTiles archives for offline usage.

### Host your own tile server

If loading times are important to you, you can serve the tiles with your own
tile server. Here are some example tile servers you can use:

- [Tileserver-GL](https://github.com/maptiler/tileserver-gl): Serve vector tiles
  from PMTiles or MBTiles
  and generate your own raster tiles on the fly.
- [Caddy with the pmtiles_proxy plugin](https://docs.protomaps.com/deploy/server#caddy):
  Serve vector tiles from PMTiles via Caddy webserver.
- [Martin](https://github.com/maplibre/martin): Serve vector tiles from PMTiles
  or MBTiles. Written in Rust.

### Generate your own tiles

#### Fetch data from OSM

Both scrips require `osmctools` to be installed.

```bash
sudo apt install -y osmctools
```

##### Create a new `seamarks.osm.pbf` file

- Use [./osm/create.sh](./osm/create.sh) to generate a new file.
- This will take a long time download, convert and extract data.
- You need to have at least 200GB free disk space.

##### Update an existing `seamarks.osm.pbf` file

- Use [./osm/update.sh](./osm/update.sh) to update a file.
- Do not use this to update a file that is outdated multiple weeks, create a new
  file instead.

#### Vector MBTiles generation

We use tilemaker to split OSM data into Mapbox Vector Tiles that get stored in
an MBTiles archive. All necessary files are located
in [./tilemaker](./tilemaker).

Tilemaker requires the `--skip-integrity` flag to run
successfully ([docs](https://github.com/systemed/tilemaker/blob/master/docs/RUNNING.md#output-messages)).

- [OSM sea mark tags](https://wiki.openstreetmap.org/wiki/Seamarks/Seamark_Objects)
- [Tilemaker config](https://github.com/systemed/tilemaker/blob/master/docs/CONFIGURATION.md)

## Development

The tile schema is defined via tilemaker config files:

- [./tilemaker/config.json](./tilemaker/config.json) that defines what layer
  should be included at what zoom level
- [./tilemaker/process.lua](./tilemaker/process.lua) maps the relations to the
  corresponding mvt layers.

## References

- [S-57 Symbols, Singapore, 2011](https://www.mpa.gov.sg/docs/mpalibraries/default-document-library/who-we-are/about-mpa/chart-symbols-and-abbreviations/chart1_jan13.pdf?sfvrsn=a56e5e18_3)
- [INT-1 Symbols, India, Edition 2, 2011](https://hydrobharat.gov.in/wp-content/uploads/2019/07/INP_5020_INT1.pdf)
- [INT-1 Symbols, UK, Edition 8, 2020](https://www.hydro.navy.mi.th/standard/INT1_EN_Ed8.pdf)
- [OSM Seamark Objects](https://wiki.openstreetmap.org/wiki/Seamarks/Seamark_Objects)
