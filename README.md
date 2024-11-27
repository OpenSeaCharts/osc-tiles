# OpenSeaCharts Tiles

The scope of this repository is tile generation based on the OpenSeaCharts tile
schema. You can download generated data directly from the GitHub releases.

## Fetch data from OSM

Both scrips require `osmctools` to be installed. 

```bash
sudo apt install -y osmctools
```

### Create a new `seamarks.osm.pbf` file

- Use [./osm/create.sh](./osm/create.sh) to generate a new file. 
- This will take a long time and requires a lot of disk space.

### Update an existing `seamarks.osm.pbf` file

- Use [./osm/update.sh](./osm/update.sh) to update a file.
- Do not use this to update a file that is outdated multiple weeks, create a new file instead.

## Vector MBTiles generation

We use tilemaker to split OSM data into an MBTiles archive. All necessary config
files are located at [./tilemaker](./tilemaker).

- [OSM sea mark tags](https://wiki.openstreetmap.org/wiki/Seamarks/Seamark_Objects)
- [Tilemaker config](https://github.com/systemed/tilemaker/blob/master/docs/CONFIGURATION.md)
