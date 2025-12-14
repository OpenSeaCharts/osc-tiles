# OpenSeaCharts Schema Documentation

This document describes the data model for OpenSeaCharts vector tiles.

## Anchorage

An area where vessels may anchor.

**Geometries:** node, area

**Sources:** anchorage

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:anchorage:category` | The category of the anchorage. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:anchorage:id` | The OSM ID of the object |

## AnchorBerth

A designated area or point for a vessel to anchor.

**Geometries:** node, area

**Sources:** anchor_berth

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:anchor_berth:category` | The category of the anchor berth. |
| radius | `float64` | `seamark:anchor_berth:radius` | The radius of the anchor berth in meters. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:anchor_berth:id` | The OSM ID of the object |

## Beacon

A fixed signal, mark, or light erected for the guidance of mariners.

**Geometries:** node

**Sources:** beacon_lateral, beacon_cardinal, beacon_isolated_danger, beacon_safe_water, beacon_special_purpose, beacon

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:<source>:category` | The specific category of the beacon. |
| colour | `Array` | `seamark:<source>:colour` | The colour of the beacon. |
| colourPattern | `Array` | `seamark:<source>:colour_pattern` | The pattern of the colours on the beacon. |
| shape | `Array` | `seamark:<source>:shape` | The physical shape of the beacon. |
| function | `string` | `seamark:type` | The function or purpose of the beacon (e.g., lateral, cardinal). |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:<source>:id` | The OSM ID of the object |

## Berth

A place where a vessel may be moored or secured.

**Geometries:** node, way, area

**Sources:** berth

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| minimumDepth | `float64` | `seamark:berth:minimum_depth` | The minimum depth of water at the berth in meters. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:berth:id` | The OSM ID of the object |

## Bridge

A structure carrying a road, path, railway, etc. across a river, road, or other obstacle.

**Geometries:** node, way, area

**Sources:** bridge

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:bridge:category` | The type of bridge construction. |
| clearanceHeight | `float64` | `seamark:bridge:clearance_height` | The vertical clearance under the bridge in meters. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:bridge:id` | The OSM ID of the object |

## Building

A building with a specific function related to maritime navigation or administration.

**Geometries:** node, way, area

**Sources:** building

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| function | `Array` | `seamark:building:function` | The function or purpose of the building. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:building:id` | The OSM ID of the object |

## BunkerStation

A station where vessels can take on fuel, water, or ballast.

**Geometries:** node, way, area

**Sources:** bunker_station

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:bunker_station:category` | The type of supplies available at the bunker station. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:bunker_station:id` | The OSM ID of the object |

## Buoy

A floating object moored to the bottom to mark a channel, hazard, or for other purposes.

**Geometries:** node

**Sources:** buoy_lateral, buoy_cardinal, buoy_isolated_danger, buoy_safe_water, buoy_special_purpose, buoy_installation, buoy

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:<source>:category` | The specific category of the buoy. |
| colour | `Array` | `seamark:<source>:colour` | The colour of the buoy. |
| colourPattern | `Array` | `seamark:<source>:colour_pattern` | The pattern of the colours on the buoy. |
| shape | `Array` | `seamark:<source>:shape` | The physical shape of the buoy. |
| function | `string` | `seamark:type` | The function or purpose of the buoy (e.g., lateral, cardinal). |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:<source>:id` | The OSM ID of the object |

## CableArea

An area where cables are laid.

**Geometries:** area

**Sources:** cable_area

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:cable_area:id` | The OSM ID of the object |

## CableOverhead

An overhead cable.

**Geometries:** way

**Sources:** cable_overhead

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:cable_overhead:id` | The OSM ID of the object |

## CableSubmarine

A submarine cable.

**Geometries:** way

**Sources:** cable_submarine

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:cable_submarine:id` | The OSM ID of the object |

## Checkpoint

A place where checks are carried out.

**Geometries:** node, area

**Sources:** checkpoint

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:checkpoint:category` | The category of the checkpoint. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:checkpoint:id` | The OSM ID of the object |

## CoastguardStation

A station for the coastguard.

**Geometries:** node, area

**Sources:** coastguard_station

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:coastguard_station:id` | The OSM ID of the object |

## Crane

A machine for lifting heavy objects.

**Geometries:** node, area

**Sources:** crane

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:crane:category` | The category of the crane. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:crane:id` | The OSM ID of the object |

## Daymark

A daytime mark.

**Geometries:** node

**Sources:** daymark

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:daymark:category` | The category of the daymark. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:daymark:id` | The OSM ID of the object |

## DistanceMark

A mark indicating distance.

**Geometries:** node

**Sources:** distance_mark

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:distance_mark:category` | The category of the distance mark. |
| distance | `float64` | `seamark:distance_mark:distance` | The distance indicated by the mark. |
| units | `string` | `seamark:distance_mark:units` | The units of the distance. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:distance_mark:id` | The OSM ID of the object |

## SeaArea

An area of the sea.

**Geometries:** area

**Sources:** dredged_area, dumping_ground

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:<source>:id` | The OSM ID of the object |

## Fairway

A navigable channel.

**Geometries:** area, way

**Sources:** fairway

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| restriction | `Array` | `seamark:fairway:restriction` | Restrictions applying to the fairway. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:fairway:id` | The OSM ID of the object |

## FerryRoute

A route for ferries.

**Geometries:** way

**Sources:** ferry_route

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:ferry_route:category` | The category of the ferry route. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:ferry_route:id` | The OSM ID of the object |

## Wall

A wall.

**Geometries:** way

**Sources:** wall

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:wall:category` | The category of the wall. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:wall:id` | The OSM ID of the object |

## FogSignal

A signal used in fog.

**Geometries:** node

**Sources:** fog_signal

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:fog_signal:category` | The category of the fog signal. |
| frequency | `float64` | `seamark:fog_signal:frequency` | The frequency of the signal. |
| generation | `string` | `seamark:fog_signal:generation` | The generation method of the signal. |
| group | `string` | `seamark:fog_signal:group` | The group of the signal. |
| period | `float64` | `seamark:fog_signal:period` | The period of the signal. |
| range | `float64` | `seamark:fog_signal:range` | The range of the signal. |
| sequence | `string` | `seamark:fog_signal:sequence` | The sequence of the signal. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:fog_signal:id` | The OSM ID of the object |

## FortifiedStructure

A fortified structure.

**Geometries:** node, area

**Sources:** fortified_structure

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:fortified_structure:category` | The category of the fortified structure. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:fortified_structure:id` | The OSM ID of the object |

## FishingFacility

A facility for fishing.

**Geometries:** node, area

**Sources:** fishing_facility

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:fishing_facility:category` | The category of the fishing facility. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:fishing_facility:id` | The OSM ID of the object |

## Gate

A gate.

**Geometries:** node, way, area

**Sources:** gate

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:gate:category` | The category of the gate. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:gate:id` | The OSM ID of the object |

## Gridiron

A gridiron.

**Geometries:** node, area

**Sources:** gridiron

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| waterLevel | `string` | `seamark:gridiron:water_level` | The water level at the gridiron. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:gridiron:id` | The OSM ID of the object |

## HarbourBasin

A harbour basin.

**Geometries:** area

**Sources:** harbour_basin

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:harbour_basin:id` | The OSM ID of the object |

## Harbour

A harbour.

**Geometries:** node, area

**Sources:** harbour

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:harbour:category` | The category of the harbour. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:harbour:id` | The OSM ID of the object |

## Hulk

A hulk.

**Geometries:** node, area

**Sources:** hulk

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:hulk:category` | The category of the hulk. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:hulk:id` | The OSM ID of the object |

## Landmark

A prominent object used for navigation.

**Geometries:** node, area

**Sources:** landmark

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:landmark:category` | The category of the landmark. |
| colour | `Array` | `seamark:landmark:colour` | The colour of the landmark. |
| colourPattern | `Array` | `seamark:landmark:colour_pattern` | The colour pattern of the landmark. |
| function | `string` | `seamark:landmark:function` | The function of the landmark. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:landmark:id` | The OSM ID of the object |

## Light

A light source.

**Geometries:** node

**Sources:** light

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:light:category` | The category of the light. |
| colour | `Array` | `seamark:light:colour` | The colour of the light. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:light:id` | The OSM ID of the object |

## LightMajor

A major light.

**Geometries:** node

**Sources:** light_major

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:light_major:category` | The category of the major light. |
| character | `string` | `seamark:light_major:character` | The character of the major light. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:light_major:id` | The OSM ID of the object |

## LightMinor

A minor light.

**Geometries:** node

**Sources:** light_minor

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:light_minor:category` | The category of the minor light. |
| character | `string` | `seamark:light_minor:character` | The character of the minor light. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:light_minor:id` | The OSM ID of the object |

## LightFloat

A light float.

**Geometries:** node

**Sources:** light_float

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| colour | `Array` | `seamark:light_float:colour` | The colour of the light float. |
| colourPattern | `Array` | `seamark:light_float:colour_pattern` | The colour pattern of the light float. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:light_float:id` | The OSM ID of the object |

## LightVessel

A light vessel.

**Geometries:** node

**Sources:** light_vessel

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| colour | `Array` | `seamark:light_vessel:colour` | The colour of the light vessel. |
| colourPattern | `Array` | `seamark:light_vessel:colour_pattern` | The colour pattern of the light vessel. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:light_vessel:id` | The OSM ID of the object |

## MarineFarm

A marine farm.

**Geometries:** node, area

**Sources:** marine_farm

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:marine_farm:category` | The category of the marine farm. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:marine_farm:id` | The OSM ID of the object |

## Mooring

A mooring.

**Geometries:** node

**Sources:** mooring

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:mooring:category` | The category of the mooring. |
| colour | `Array` | `seamark:mooring:colour` | The colour of the mooring. |
| colourPattern | `Array` | `seamark:mooring:colour_pattern` | The colour pattern of the mooring. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:mooring:id` | The OSM ID of the object |

## NavigationLine

A navigation line.

**Geometries:** way

**Sources:** navigation_line

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:navigation_line:category` | The category of the navigation line. |
| orientation | `float64` | `seamark:navigation_line:orientation` | The orientation of the navigation line. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:navigation_line:id` | The OSM ID of the object |

## Notice

A notice.

**Geometries:** node

**Sources:** notice

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:notice:category` | The category of the notice. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:notice:id` | The OSM ID of the object |

## Obstruction

An obstruction.

**Geometries:** node, area

**Sources:** obstruction

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:obstruction:category` | The category of the obstruction. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:obstruction:id` | The OSM ID of the object |

## Platform

A platform.

**Geometries:** node, area

**Sources:** platform

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:platform:category` | The category of the platform. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:platform:id` | The OSM ID of the object |

## ProductionArea

A production area.

**Geometries:** area

**Sources:** production_area

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:production_area:category` | The category of the production area. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:production_area:id` | The OSM ID of the object |

## PilotBoarding

A pilot boarding place.

**Geometries:** node, area

**Sources:** pilot_boarding

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:pilot_boarding:category` | The category of the pilot boarding place. |
| channel | `string` | `seamark:pilot_boarding:channel` | The channel of the pilot boarding place. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:pilot_boarding:id` | The OSM ID of the object |

## Pile

A pile.

**Geometries:** node

**Sources:** pile

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:pile:category` | The category of the pile. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:pile:id` | The OSM ID of the object |

## RadarReflector

A radar reflector.

**Geometries:** node

**Sources:** radar_reflector

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:radar_reflector:id` | The OSM ID of the object |

## RecommendedTrack

A recommended track.

**Geometries:** way

**Sources:** recommended_track

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| orientation | `float64` | `seamark:recommended_track:orientation` | The orientation of the recommended track. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:recommended_track:id` | The OSM ID of the object |

## RescueStation

A rescue station.

**Geometries:** node, area

**Sources:** rescue_station

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:rescue_station:category` | The category of the rescue station. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:rescue_station:id` | The OSM ID of the object |

## RestrictedArea

A restricted area.

**Geometries:** area

**Sources:** restricted_area

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:restricted_area:category` | The category of the restricted area. |
| restriction | `Array` | `seamark:restricted_area:restriction` | The restriction of the restricted area. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:restricted_area:id` | The OSM ID of the object |

## SeaplaneLandingArea

A seaplane landing area.

**Geometries:** area

**Sources:** seaplane_landing_area

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| restriction | `Array` | `seamark:seaplane_landing_area:restriction` | The restriction of the seaplane landing area. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:seaplane_landing_area:id` | The OSM ID of the object |

## SignalStation

A signal station.

**Geometries:** node

**Sources:** signal_station_warning, signal_station_traffic

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:<source>:category` | The category of the signal station. |
| channel | `string` | `seamark:<source>:channel` | The channel of the signal station. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:<source>:id` | The OSM ID of the object |

## SmallCraftFacility

A facility for small craft.

**Geometries:** node, area

**Sources:** small_craft_facility

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:small_craft_facility:category` | The category of the small craft facility. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:small_craft_facility:id` | The OSM ID of the object |

## Spring

A spring.

**Geometries:** node

**Sources:** spring

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:spring:id` | The OSM ID of the object |

## Topmark

A topmark.

**Geometries:** node

**Sources:** topmark

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| colour | `Array` | `seamark:topmark:colour` | The colour of the topmark. |
| colourPattern | `Array` | `seamark:topmark:colour_pattern` | The colour pattern of the topmark. |
| shape | `Array` | `seamark:topmark:shape` | The shape of the topmark. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:topmark:id` | The OSM ID of the object |

## SeparationLane

A separation lane.

**Geometries:** area

**Sources:** separation_lane

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:separation_lane:category` | The category of the separation lane. |
| restriction | `Array` | `seamark:separation_lane:restriction` | The restriction of the separation lane. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:separation_lane:id` | The OSM ID of the object |

## SeparationLine

A separation line.

**Geometries:** way

**Sources:** separation_line

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:separation_line:category` | The category of the separation line. |
| orientation | `float64` | `seamark:separation_line:orientation` | The orientation of the separation line. |
| restriction | `Array` | `seamark:separation_line:restriction` | The restriction of the separation line. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:separation_line:id` | The OSM ID of the object |

## SeparationRoundabout

A separation roundabout.

**Geometries:** area

**Sources:** separation_roundabout

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:separation_roundabout:category` | The category of the separation roundabout. |
| restriction | `Array` | `seamark:separation_roundabout:restriction` | The restriction of the separation roundabout. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:separation_roundabout:id` | The OSM ID of the object |

## SeparationZone

A separation zone.

**Geometries:** area

**Sources:** separation_zone

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:separation_zone:category` | The category of the separation zone. |
| restriction | `Array` | `seamark:separation_zone:restriction` | The restriction of the separation zone. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:separation_zone:id` | The OSM ID of the object |

## Rock

A rock.

**Geometries:** node

**Sources:** rock

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| waterLevel | `WaterLevel` | `seamark:rock:water_level` | The water level of the rock. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:rock:id` | The OSM ID of the object |

## Wreck

A wreck.

**Geometries:** node, area

**Sources:** wreck

### Attributes

| Name | Type | OSM Tag | Description |
|------|------|---------|-------------|
| category | `Array` | `seamark:wreck:category` | The category of the wreck. |
| name | `string` | `seamark:name` | The name of the seamark |
| id | `int64` | `seamark:wreck:id` | The OSM ID of the object |

