#!/usr/bin/env bash

./tilemaker --input seamarks.osm.pbf --output seamarks.mbtiles \
  --materialize-geometries --no-compress-nodes --no-compress-ways --fast