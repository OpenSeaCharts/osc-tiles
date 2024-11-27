#!/usr/bin/env bash

echo download the latest planet.osm.pbf file
wget https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf -O planet.osm.pbf

echo convert to readable format for osmfilter and remove redundant author information
osmconvert planet.osm.pbf --drop-author --out-o5m -o=planet.o5m
#rm planet.osm.pbf
osmupdate planet.o5m planet-updated.o5m --keep-tempfiles
#rm planet.o5m

echo extract all seamarks
osmfilter planet-updated.o5m --keep="seamark:type=" -o="seamarks.o5m"
#rm planet-updated.osm.pbf

echo convert back to a osm.pbf file
osmconvert seamarks.o5m --out-pbf -o=seamarks.osm.pbf
#rm seamarks.o5m