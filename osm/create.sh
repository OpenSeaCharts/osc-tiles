#!/usr/bin/env bash

echo download the latest planet.osm.pbf file
wget https://planet.openstreetmap.org/pbf/planet-pbf-rss.xml
wget https://planet.openstreetmap.org/pbf/planet-latest.osm.pbf -O planet.osm.pbf

echo convert to readable format for osmfilter and remove redundant author information
osmconvert planet.osm.pbf --drop-author --out-o5m -o=planet.o5m
rm planet.osm.pbf

echo extract all seamarks
osmfilter planet.o5m --keep="seamark:type=" -o="seamarks-extract.o5m"
rm planet.o5m

echo update the downloaded data
lastBuildDate_rfc2822=$(grep "<lastBuildDate>" planet-pbf-rss.xml | sed -E 's|.*<lastBuildDate>(.*)</lastBuildDate>.*|\1|')
lastBuildDate_iso8601=$(date -d "$lastBuildDate_rfc2822" --utc +%Y-%m-%dT%H:%M:%SZ)
osmupdate seamarks-extract.o5m seamarks-updated.o5m "${lastBuildDate_iso8601}" --keep-tempfiles
rm seamarks-extract.o5m

echo extract all seamarks from the updated file
osmfilter seamarks-updated.o5m --keep="seamark:type=" -o="seamarks-updated-extract.o5m"
rm seamarks-updated.o5m

echo convert back to a osm.pbf file
osmconvert seamarks-updated-extract.o5m --out-pbf -o=seamarks.osm.pbf
rm seamarks.o5m
osmconvert seamarks.osm.pbf --out-statistics
