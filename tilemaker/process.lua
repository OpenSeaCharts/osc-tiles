function init_function(name)
end

function exit_function()
end

-- list of those OSM tags which indicate that a node should be processed
node_keys = { "seamark:type" }
-- list of those OSM tags which indicate that a way should be processed
way_keys = { "seamark:type" }

-- function to process an OSM node and add it to layers
function node_function()
    local type = Find("seamark:type")
    case = {
        anchorage = function()
            Layer("anchorage", false)
            Attribute("category", Find("seamark:anchorage:category"))
        end,
        anchor_berth = function()
            Layer("anchor_berth", false)
            Attribute("category", Find("seamark:anchor_berth:category"))
        end,
        berth = function()
            Layer("berth", false)
        end,
        bridge = function()
            Layer("bridge", false)
        end,
        bunker_station = function()
            Layer("bunker_station", false)
        end,
        building = function()
            Layer("building", false)
        end,
        harbour = function()
            Layer("harbour", false)
        end,
        notice = function()
            Layer("notice", false)
        end,
        pile = function()
            Layer("pile", false)
        end,
        retro_reflector = function()
            Layer("retro_reflector", false)
        end,
        sand_waves = function()
            Layer("sand_waves", false)
        end,
        sea_area = function()
            Layer("sea_area", false)
        end,
        seaplane_landing_area = function()
            Layer("seaplane_landing_area", false)
        end,
        spring = function()
            Layer("spring", false)
        end,
        topmark = function()
            Layer("topmark", false)
        end,
        rock = function()
            Layer("rock", false)
        end,
        vegetation = function()
            Layer("vegetation", false)
        end,
        weed = function()
            Layer("weed", false)
        end,
        wreck = function()
            Layer("wreck", false)
        end,
    }
    if case[type] then
        case[type]()
        Attribute("name", Find("seamark:name"))
    end
end

-- function to process an OSM way and add it to layers
function way_function()
    local type = Find("seamark:type")
    case = {
        anchorage = function()
            Layer("anchorage", true)
            Attribute("category", Find("seamark:anchorage:category"))
        end,
        anchor_berth = function()
            Layer("anchor_berth", true)
            Attribute("category", Find("seamark:anchor_berth:category"))
        end,
        berth = function()
            Layer("berth", Area() ~= 0)
        end,
        bridge = function()
            Layer("bridge", Area() ~= 0)
            Attribute("category", Find("seamark:bridge:category"))
            Attribute("clearance", Find("seamark:bridge:clearance"))
        end,
        bunker_station = function()
            Layer("bunker_station", true)
            Attribute("category", Find("seamark:bunker_station:category"))
        end,
        building = function()
            Layer("building", true)
        end,
        cable_area = function()
            Layer("cable_area", true)
            Attribute("category", Find("seamark:cable_area:category"))
            Attribute("restriction", Find("seamark:cable_area:restriction"))
        end,
        cable_overhead = function()
            Layer("cable", false)
            Attribute("category", Find("seamark:cable_overhead:category"))
        end,
        cable_submarine = function()
            Layer("cable", false)
            Attribute("category", Find("seamark:cable_submarine:category"))
        end,
        causeway = function()
            Layer("causeway", true)
            Attribute("water_level", Find("seamark:causeway:water_level"))
        end,
        checkpoint = function()
            Layer("checkpoint", true)
            Attribute("category", Find("seamark:checkpoint:category"))
        end,
        coastguard_station = function()
            Layer("coastguard_station", true)
        end,
        dredged_area = function()
            Layer("dredged_area", true)
        end,
        dumping_ground = function()
            Layer("dumping_ground", true)
        end,
        exceptional_structure = function()
            Layer("exceptional_structure", Area() ~= 0)
            Attribute("category", Find("seamark:exceptional_structure:category"))
        end,
        fairway = function()
            Layer("fairway", true)
            Attribute("restriction", Find("seamark:fairway:restriction"))
        end,
        ferry_route = function()
            Layer("ferry_route", false)
            Attribute("category", Find("seamark:ferry_route:category"))
        end,
        wall = function()
            Layer("wall", false)
            Attribute("category", Find("seamark:wall:category"))
        end,
        fortified_structure = function()
            Layer("fortified_structure", Area() ~= 0)
            Attribute("category", Find("seamark:fortified_structure:category"))
        end,
        fishing_facility = function()
            Layer("fishing_facility", Area() ~= 0)
            Attribute("category", Find("seamark:fishing_facility:category"))
        end,
        gate = function()
            Layer("gate", Area() ~= 0)
            Attribute("category", Find("seamark:gate:category"))
        end,
        gridiron = function()
            Layer("gridiron", true)
        end,
        harbour_basin = function()
            Layer("harbour_basin", true)
        end,
        harbour = function()
            Layer("harbour", true)
            Attribute("category", Find("seamark:harbour:category"))
        end,
        hulk = function()
            Layer("hulk", true)
            Attribute("category", Find("seamark:hulk:category"))
        end,
        inshore_traffic_zone = function()
            Layer("inshore_traffic_zone", true)
            Attribute("restriction", Find("seamark:inshore_traffic_zone:restriction"))
        end,
        landmark = function()
            Layer("landmark", Area() ~= 0)
            Attribute("category", Find("seamark:landmark:category"))
        end,
        light = function()
            Layer("light", true)
            Attribute("category", Find("seamark:light:category"))
            Attribute("character", Find("seamark:light:character"))
            Attribute("color", Find("seamark:light:colour"))
        end,
        light_major = function()
            Layer("light", true)
            Attribute("category", Find("seamark:light_major:category"))
            Attribute("character", Find("seamark:light_major:character"))
            Attribute("color", Find("seamark:light_major:colour"))
        end,
        light_minor = function()
            Layer("light", true)
            Attribute("category", Find("seamark:light_minor:category"))
            Attribute("character", Find("seamark:light_minor:character"))
            Attribute("color", Find("seamark:light_minor:colour"))
        end,
        lock_basin = function()
            Layer("lock_basin", true)
        end,
        marine_farm = function()
            Layer("marine_farm", true)
            Attribute("category", Find("seamark:marine_farm:category"))
            Attribute("restriction", Find("seamark:marine_farm:restriction"))
            Attribute("water_level", Find("seamark:marine_farm:water_level"))
        end,
        military_area = function()
            Layer("military_area", true)
            Attribute("category", Find("seamark:military_area:category"))
            Attribute("restriction", Find("seamark:restriction:restriction"))
        end,
        mooring = function()
            Layer("mooring", true)
            Attribute("category", Find("seamark:mooring:category"))
            Attribute("color", Find("seamark:mooring:colour"))
        end,
        recommended_route_centreline = function()
            Layer("recommended_route_centreline", false)
        end,
        navigation_line = function()
            Layer("navigation_line", false)
            Attribute("category", Find("seamark:navigation_line:category"))
            Attribute("orientation", Find("seamark:navigation_line:orientation"))
        end,
        obstruction = function()
            Layer("obstruction", Area() ~= 0)
            Attribute("category", Find("seamark:obstruction:category"))
            Attribute("water_level", Find("seamark:obstruction:water_level"))
        end,
        oil_barrier = function()
            Layer("oil_barrier", false)
        end,
        platform = function()
            Layer("platform", true)
            Attribute("category", Find("seamark:platform:category"))
            Attribute("color", Find("seamark:platform:colour"))
        end,
        production_area = function()
            Layer("production_area", true)
            Attribute("category", Find("seamark:production_area:category"))
        end,
        pipeline_area = function()
            Layer("pipeline_area", true)
            Attribute("category", Find("seamark:pipeline_area:category"))
            Attribute("condition", Find("seamark:pipeline_area:condition"))
            Attribute("restriction", Find("seamark:pipeline_area:restriction"))
        end,
        pipeline_overhead = function()
            Layer("pipeline", false)
            Attribute("category", Find("seamark:pipeline_submarine:category"))
        end,
        pipeline_submarine = function()
            Layer("pipeline", false)
            Attribute("category", Find("seamark:pipeline_submarine:category"))
        end,
        pontoon = function()
            Layer("pontoon", Area() ~= 0)
        end,
        precautionary_area = function()
            Layer("precautionary_area", true)
        end,
        pylon = function()
            Layer("pylon", true)
            Attribute("category", Find("seamark:pylon:category"))
            Attribute("water_level", Find("seamark:pylon:water_level"))
        end,
        radar_line = function()
            Layer("radar_line", false)
        end,
        radar_range = function()
            Layer("radar_range", true)
        end,
        ["calling-in_point"] = function()
            Layer("calling-in_point", false)
            Attribute("channel", Find("seamark:calling-in_point:channel"))
            Attribute("orientation", Find("seamark:calling-in_point:orientation"))
            Attribute("traffic_flow", Find("seamark:calling-in_point:traffic_flow"))
        end,
        recommended_route_centreline = function()
            Layer("recommended_route_centreline", false)
        end,
        recommended_track = function()
            Layer("recommended_track", false)
            Attribute("traffic_flow", Find("seamark:recommended_track:traffic_flow"))
            Attribute("orientation", Find("seamark:recommended_track:orientation"))
        end,
        recommended_traffic_lane = function()
            Layer("recommended_traffic_lane", false)
            Attribute("orientation", Find("seamark:recommended_traffic_lane:orientation"))
        end,
        rescue_station = function()
            Layer("rescue_station", true)
            Attribute("category", Find("seamark:rescue_station:category"))
        end,
        restricted_area = function()
            Layer("restricted_area", true)
            Attribute("category", Find("seamark:restricted_area:category"))
            Attribute("restriction", Find("seamark:restricted_area:restriction"))
        end,
        sand_waves = function()
            Layer("sand_waves", true)
        end,
        seabed_area = function()
            Layer("seabed_area", Area() ~= 0)
            Attribute("surface", Find("seamark:seabed_area:surface"))
            Attribute("surface_qualification", Find("seamark:seabed_area:surface_qualification"))
            Attribute("water_level", Find("seamark:seabed_area:water_level"))
        end,
        sea_area = function()
            Layer("sea_area", true)
            Attribute("category", Find("seamark:sea_area:category"))
        end,
        seagrass = function()
            Layer("seagrass", true)
            Attribute("category", Find("seamark:seagrass:category"))
        end,
        seaplane_landing_area = function()
            Layer("seaplane_landing_area", true)
            Attribute("restriction", Find("seamark:seaplane_landing_area:restriction"))
        end,
        tank = function()
            Layer("tank", true)
            Attribute("category", Find("seamark:tank:category"))
            Attribute("color", Find("seamark:tank:colour"))
        end,
        shoreline_construction = function()
            Layer("shoreline_construction", true)
            Attribute("category", Find("seamark:shoreline_construction:category"))
            Attribute("construction", Find("seamark:shoreline_construction:construction"))
        end,
        small_craft_facility = function()
            Layer("small_craft_facility", Area() ~= 0)
            Attribute("category", Find("seamark:small_craft_facility:category"))
        end,
        submarine_transit_lane = function()
            Layer("submarine_transit_lane", true)
            Attribute("restriction", Find("seamark:submarine_transit_lane:restriction"))
        end,
        separation_boundary = function()
            Layer("separation_boundary", false)
            Attribute("category", Find("seamark:separation_boundary:category"))
        end,
        separation_crossing = function()
            Layer("separation_crossing", true)
            Attribute("category", Find("seamark:separation_crossing:category"))
            Attribute("restriction", Find("seamark:separation_crossing:restriction"))
        end,
        separation_lane = function()
            Layer("separation_lane", false)
            Attribute("category", Find("seamark:separation_lane:category"))
            Attribute("restriction", Find("seamark:separation_lane:restriction"))
        end,
        separation_line = function()
            Layer("separation_line", false)
            Attribute("category", Find("seamark:separation_line:category"))
            Attribute("orientation", Find("seamark:separation_line:orientation"))
            Attribute("restriction", Find("seamark:separation_line:restriction"))
        end,
        separation_roundabout = function()
            Layer("separation_roundabout", true)
            Attribute("category", Find("seamark:separation_roundabout:category"))
            Attribute("restriction", Find("seamark:separation_roundabout:restriction"))
        end,
        separation_zone = function()
            Layer("separation_zone", true)
            Attribute("category", Find("seamark:separation_zone:category"))
            Attribute("restriction", Find("seamark:separation_zone:restriction"))
        end,
        turning_basin = function()
            Layer("turning_basin", true)
        end,
        ["two-way_route"] = function()
            Layer("two-way_route", false)
        end,
        vegetation = function()
            Layer("vegetation", Area() ~= 0)
            Attribute("category", Find("seamark:vegetation:category"))
        end,
        vehicle_transfer = function()
            Layer("vehicle_transfer", true)
            Attribute("category", Find("seamark:vehicle_transfer:category"))
        end,
        water_turbulence = function()
            Layer("water_turbulence", Area() ~= 0)
            Attribute("category", Find("seamark:water_turbulence:category"))
        end,
        weed = function()
            Layer("weed", true)
            Attribute("category", Find("seamark:weed:category"))
        end,
        wreck = function()
            Layer("wreck", true)
            Attribute("category", Find("seamark:wreck:category"))
            Attribute("depth", Find("seamark:wreck:depth"))
        end,
    }
    if case[type] then
        case[type]()
        Attribute("name", Find("seamark:name"))
    end
end

function relation_scan_function()
end

function attribute_function(attr, layer)
end