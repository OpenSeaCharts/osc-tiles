#!/usr/bin/env bash

echo convert to o5m
osmconvert seamarks-old.osm.pbf --out-o5m -o=seamarks-old.o5m

echo update the data
osmupdate seamarks-old.o5m seamarks-updated.o5m

echo extract all seamarks
osmfilter seamarks-updated.o5m --keep="seamark:type=" -o="seamarks.o5m"

echo convert back to a osm.pbf file
osmconvert seamarks.o5m --out-pbf -o="seamarks.osm.pbf"

echo statistics for the updated seamarks.osm.pbf
osmconvert seamarks.osm.pbf --out-statistics