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
            Attribute("restriction", Find("seamark:anchorage:restriction"))
        end,
        anchor_berth = function()
            Layer("anchor_berth", false)
            Attribute("category", Find("seamark:anchor_berth:category"))
            Attribute("radius", Find("seamark:anchor_berth:radius"))
        end,
        beacon = function()
            Layer("beacon", false)
            Attribute("category", Find("seamark:beacon_cardinal:category"))
            Attribute("color_pattern", Find("seamark:beacon_cardinal:colour_pattern"))
            Attribute("construction", Find("seamark:beacon_cardinal:construction"))
            Attribute("reflectivity", Find("seamark:beacon_cardinal:reflectivity"))
            Attribute("shape", Find("seamark:beacon_cardinal:shape"))
        end,
        beacon_isolated_danger = function()
            Layer("beacon", false)
            Attribute("category", "isolated_danger")
            Attribute("color_pattern", Find("seamark:beacon_isolated_danger:colour_pattern"))
            Attribute("construction", Find("seamark:beacon_isolated_danger:construction"))
            Attribute("reflectivity", Find("seamark:beacon_isolated_danger:reflectivity"))
            Attribute("shape", Find("seamark:beacon_isolated_danger:shape"))
        end,
        beacon_lateral = function()
            Layer("beacon", false)
            Attribute("category", Find("seamark:beacon_lateral:category"))
            Attribute("color_pattern", Find("seamark:beacon_lateral:colour_pattern"))
            Attribute("construction", Find("seamark:beacon_lateral:construction"))
            Attribute("reflectivity", Find("seamark:beacon_lateral:reflectivity"))
            Attribute("shape", Find("seamark:beacon_lateral:shape"))
        end,
        beacon_safe_water = function()
            Layer("beacon", false)
            Attribute("category", "safe_water")
            Attribute("color_pattern", Find("seamark:beacon_safe_water:colour_pattern"))
            Attribute("construction", Find("seamark:beacon_safe_water:construction"))
            Attribute("reflectivity", Find("seamark:beacon_safe_water:reflectivity"))
            Attribute("shape", Find("seamark:beacon_safe_water:shape"))
        end,
        beacon_special_purpose = function()
            Layer("beacon", false)
            Attribute("category", Find("seamark:beacon_special_purpose:category"))
            Attribute("color_pattern", Find("seamark:beacon_special_purpose:colour_pattern"))
            Attribute("construction", Find("seamark:beacon_special_purpose:construction"))
            Attribute("reflectivity", Find("seamark:beacon_special_purpose:reflectivity"))
            Attribute("shape", Find("seamark:beacon_special_purpose:shape"))
        end,
        berth = function()
            Layer("berth", false)
            Attribute("minimum_depth", Find("seamark:berth:minimum_depth"))
        end,
        bridge = function()
            Layer("bridge", false)
            Attribute("category", Find("seamark:bridge:category"))
            Attribute("color_pattern", Find("seamark:bridge:colour_pattern"))
            Attribute("construction", Find("seamark:bridge:construction"))
            Attribute("reflectivity", Find("seamark:bridge:reflectivity"))
        end,
        bunker_station = function()
            Layer("bunker_station", false)
            Attribute("category", Find("seamark:bunker_station:category"))
        end,
        building = function()
            Layer("building", false)
            Attribute("color_pattern", Find("seamark:building:colour_pattern"))
            Attribute("reflectivity", Find("seamark:building:reflectivity"))
            Attribute("shape", Find("seamark:building:shape"))
        end,
        buoy_cardinal = function()
            Layer("buoy", false)
            Attribute("category", Find("seamark:buoy_cardinal:category"))
            Attribute("color_pattern", Find("seamark:buoy_cardinal:colour_pattern"))
            Attribute("reflectivity", Find("seamark:buoy_cardinal:reflectivity"))
        end,
        buoy_isolated_danger = function()
            Layer("buoy", false)
            Attribute("category", "isolated_danger")
            Attribute("color_pattern", Find("seamark:buoy_isolated_danger:colour_pattern"))
            Attribute("reflectivity", Find("seamark:buoy_isolated_danger:reflectivity"))
            Attribute("shape", Find("seamark:buoy_isolated_danger:shape"))
        end,
        buoy_lateral = function()
            Layer("buoy", false)
            Attribute("category", Find("seamark:buoy_lateral:category"))
            Attribute("color_pattern", Find("seamark:buoy_lateral:colour_pattern"))
            Attribute("reflectivity", Find("seamark:buoy_lateral:reflectivity"))
            Attribute("shape", Find("seamark:buoy_lateral:shape"))
        end,
        buoy_safe_water = function()
            Layer("buoy", false)
            Attribute("category", "safe_water")
            Attribute("color_pattern", Find("seamark:buoy_safe_water:colour_pattern"))
            Attribute("reflectivity", Find("seamark:buoy_safe_water:reflectivity"))
            Attribute("shape", Find("seamark:buoy_safe_water:shape"))
        end,
        buoy_special_purpose = function()
            Layer("buoy", false)
            Attribute("category", Find("seamark:buoy_special_purpose:category"))
            Attribute("color_pattern", Find("seamark:buoy_special_purpose:colour_pattern"))
            Attribute("reflectivity", Find("seamark:buoy_special_purpose:reflectivity"))
            Attribute("shape", Find("seamark:buoy_special_purpose:shape"))
        end,
        coastguard_station = function()
            Layer("coastguard_station", false)
        end,
        crane = function()
            Layer("crane", false)
            Attribute("category", Find("seamark:crane:category"))
        end,
        control_point = function()
            Layer("control_point", false)
            Attribute("category", Find("seamark:control_point:category"))
        end,
        daymark = function()
            Layer("daymark", false)
            Attribute("category", Find("seamark:daymark:category"))
            Attribute("color_pattern", Find("seamark:daymark:colour_pattern"))
            Attribute("shape", Find("seamark:daymark:shape"))
        end,
        distance_mark = function()
            Layer("distance_mark", false)
            Attribute("category", Find("seamark:distance_mark:category"))
            Attribute("distance", Find("seamark:distance_mark:distance"))
            Attribute("unit", Find("seamark:distance_mark:units"))
        end,
        exceptional_structure = function()
            Layer("exceptional_structure", false)
            Attribute("category", Find("seamark:exceptional_structure:category"))
        end,
        fog_signal = function()
            Layer("fog_signal", false)
            Attribute("category", Find("seamark:fog_signal:category"))
            Attribute("frequency", Find("seamark:fog_signal:frequency"))
            Attribute("generation", Find("seamark:fog_signal:generation"))
            Attribute("period", Find("seamark:fog_signal:period"))
            Attribute("range", Find("seamark:fog_signal:range"))
            Attribute("sequence", Find("seamark:fog_signal:sequence"))
        end,
        fortified_structure = function()
            Layer("fortified_structure", false)
            Attribute("category", Find("seamark:fortified_structure:category"))
        end,
        fishing_facility = function()
            Layer("fishing_facility", false)
            Attribute("category", Find("seamark:fishing_facility:category"))
        end,
        gate = function()
            Layer("gate", false)
            Attribute("category", Find("seamark:gate:category"))
        end,
        gridiron = function()
            Layer("gridiron", false)
            Attribute("category", Find("seamark:gridiron:water_level"))
        end,
        harbour = function()
            Layer("harbour", false)
            Attribute("category", Find("seamark:harbour:category"))
        end,
        hulk = function()
            Layer("hulk", false)
            Attribute("category", Find("seamark:hulk:category"))
        end,
        inshore_traffic_zone = function()
            Layer("inshore_traffic_zone", false)
            Attribute("restriction", Find("seamark:inshore_traffic_zone:restriction"))
        end,
        landmark = function()
            Layer("landmark", false)
            Attribute("category", Find("seamark:landmark:category"))
            Attribute("color_pattern", Find("seamark:landmark:colour_pattern"))
            Attribute("reflectivity", Find("seamark:landmark:reflectivity"))
        end,
        light = function() end,
        light_major = function() end,
        light_minor = function() end,
        light_float = function()
            Layer("light_float", false)
            Attribute("category", Find("seamark:light_float:category"))
        end,
        light_vessel = function()
            Layer("light_vessel", false)
            Attribute("color_pattern", Find("seamark:light_vessel:colour_pattern"))
            Attribute("reflectivity", Find("seamark:light_vessel:reflectivity"))
        end,
        marine_farm = function()
            Layer("marine_farm", false)
            Attribute("category", Find("seamark:marine_farm:category"))
            Attribute("restriction", Find("seamark:marine_farm:restriction"))
            Attribute("water_level", Find("seamark:marine_farm:water_level"))
        end,
        military_area = function()
            Layer("military_area", false)
            Attribute("category", Find("seamark:military_area:category"))
            Attribute("restriction", Find("seamark:military_area:restriction"))
        end,
        mooring = function()
            Layer("mooring", false)
            Attribute("category", Find("seamark:mooring:category"))
            Attribute("color_pattern", Find("seamark:mooring:colour_pattern"))
            Attribute("reflectivity", Find("seamark:mooring:reflectivity"))
            Attribute("shape", Find("seamark:mooring:shape"))
        end,
        notice = function()
            Layer("notice", false)
            Attribute("category", Find("seamark:notice:category"))
            Attribute("addition", Find("seamark:notice:addition"))
            Attribute("condition", Find("seamark:notice:condition"))
            Attribute("function", Find("seamark:notice:function"))
        end,
        obstruction = function()
            Layer("obstruction", false)
            Attribute("category", Find("seamark:obstruction:category"))
        end,
        platform = function()
            Layer("platform", false)
            Attribute("category", Find("seamark:platform:category"))
            Attribute("color_pattern", Find("seamark:platform:colour_pattern"))
            Attribute("condition", Find("seamark:platform:condition"))
            Attribute("reflectivity", Find("seamark:platform:reflectivity"))
        end,
        pilot_boarding = function()
            Layer("pilot_boarding", false)
            Attribute("category", Find("seamark:pilot_boarding:category"))
            Attribute("channel", Find("seamark:pilot_boarding:channel"))
        end,
        pile = function()
            Layer("pile", false)
            Attribute("category", Find("seamark:pile:category"))
            Attribute("color_pattern", Find("seamark:pile:colour_pattern"))
            Attribute("condition", Find("seamark:pile:condition"))
        end,
        precautionary_area = function()
            Layer("precautionary_area", false)
            Attribute("restriction", Find("seamark:pile:restriction"))
        end,
        pylon = function()
            Layer("pylon", false)
            Attribute("category", Find("seamark:pylon:category"))
        end,
        radar_reflector = function()
            Layer("radar_reflector", false)
        end,
        radar_transponder = function()
            Layer("radar_transponder", false)
            Attribute("category", Find("seamark:radar_transponder:category"))
        end,
        radar_station = function()
            Layer("radar_station", false)
            Attribute("category", Find("seamark:radar_station:category"))
            Attribute("channel", Find("seamark:radar_station:channel"))
        end,
        ["calling-in_point"] = function()
            Layer("calling-in_point", false)
            Attribute("channel", Find("seamark:calling-in_point:channel"))
            Attribute("orientation", Find("seamark:calling-in_point:orientation"))
            Attribute("traffic_flow", Find("seamark:calling-in_point:traffic_flow"))
        end,
        radio_station = function()
            Layer("radio_station", false)
            Attribute("category", Find("seamark:radio_station-in_point:category"))
            Attribute("callsign", Find("seamark:radio_station-in_point:callsign"))
            Attribute("channel", Find("seamark:radio_station-in_point:channel"))
            Attribute("frequency", Find("seamark:radio_station-in_point:frequency"))
        end,
        rescue_station = function()
            Layer("rescue_station", false)
            Attribute("category", Find("seamark:rescue_station:category"))
        end,
        retro_reflector = function()
            Layer("retro_reflector", false)
        end,
        sand_waves = function()
            Layer("sand_waves", false)
        end,
        seabed_area = function()
            Layer("seabed_area", false)
            Attribute("surface", Find("seamark:seabed_area:surface"))
        end,
        sea_area = function()
            Layer("sea_area", false)
            Attribute("category", Find("seamark:rescue_station:category"))
        end,
        seagrass = function()
            Layer("seagrass", false)
            Attribute("category", Find("seamark:seagrass:category"))
        end,
        seaplane_landing_area = function()
            Layer("seaplane_landing_area", false)
            Attribute("restriction", Find("seamark:seaplane_landing_area:restriction"))
        end,
        tank = function()
            Layer("tank", false)
            Attribute("colour_pattern", Find("seamark:tank:colour_pattern"))
            Attribute("construction", Find("seamark:tank:construction"))
            Attribute("reflectivity", Find("seamark:tank:reflectivity"))
        end,
        shoreline_construction = function()
            Layer("shoreline_construction", false)
            Attribute("category", Find("seamark:shoreline_construction:category"))
            Attribute("construction", Find("seamark:shoreline_construction:construction"))
            Attribute("reflectivity", Find("seamark:shoreline_construction:reflectivity"))
        end,
        signal_station_traffic = function()
            Layer("signal_station", false)
            Attribute("category", Find("seamark:signal_station_traffic:category"))
            Attribute("channel", Find("seamark:signal_station_traffic:channel"))
        end,
        signal_station_warning = function()
            Layer("signal_station", false)
            Attribute("category", Find("seamark:signal_station_warning:category"))
            Attribute("channel", Find("seamark:signal_station_warning:channel"))
        end,
        small_craft_facility = function()
            local categories = split(Find("seamark:small_craft_facility:category"), ";")
            local length = #categories
            local isEven = length % 2 == 0
            for i = 0, length - 1 do
                Layer("small_craft_facility", false)
                -- starts with index 1
                Attribute("category", categories[i + 1])
                if (isEven) then
                    AttributeNumeric("offset_x", i)
                    AttributeNumeric("offset_y", 0)
                else
                    AttributeNumeric("offset_x", i - 0.5)
                    AttributeNumeric("offset_y", 0)
                end
            end
        end,
        spring = function()
            Layer("spring", false)
        end,
        topmark = function()
            Layer("topmark", false)
            Attribute("color_pattern", Find("seamark:small_craft_facility:colour_pattern"))
            Attribute("shape", Find("seamark:small_craft_facility:shape"))
        end,
        turning_basin = function()
            Layer("turning_basin", false)
        end,
        rock = function()
            Layer("rock", false)
            Attribute("surface", Find("seamark:rock:surface"))
            Attribute("surface_qualification", Find("seamark:rock:surface_qualification"))
        end,
        vegetation = function()
            Layer("vegetation", false)
            Attribute("category", Find("seamark:vegetation:category"))
        end,
        virtual_aton = function()
            Layer("virtual_aton", false)
            Attribute("category", Find("seamark:virtual_aton:category"))
        end,
        vehicle_transfer = function()
            Layer("vehicle_transfer", false)
            Attribute("category", Find("seamark:vehicle_transfer:category"))
        end,
        water_turbulence = function()
            Layer("water_turbulence", false)
            Attribute("category", Find("seamark:water_turbulence:category"))
        end,
        waterway_gauge = function()
            Layer("waterway_gauge", false)
            Attribute("category", Find("seamark:waterway_gauge:category"))
        end,
        weed = function()
            Layer("weed", false)
            Attribute("category", Find("seamark:weed:category"))
        end,
        wreck = function()
            Layer("wreck", false)
            Attribute("category", Find("seamark:wreck:category"))
            Attribute("depth", Find("seamark:wreck:depth"))
            Attribute("reflectivity", Find("seamark:wreck:reflectivity"))
        end,
    }
    if case[type] then
        case[type]()
        Attribute("name", Find("seamark:name"))
        if (Holds("seamark:light:colour")) then
            local lights = split(Find("seamark:light:colour"), ";")
            for i = 0, #lights - 1 do
                Layer("light", false)
                Attribute("color", lights[i + 1])
                AttributeNumeric("index", i)
                Attribute("character", Find("seamark:light:character"))
            end
        end
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
        light = function() end,
        light_major = function() end,
        light_minor = function() end,
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
        if (Holds("seamark:light:colour")) then
            local lights = split(Find("seamark:light:colour"), ";")
            for i = 0, #lights - 1 do
                Layer("light", false)
                Attribute("color", lights[i + 1])
                AttributeNumeric("index", i)
                Attribute("character", Find("seamark:light:character"))
            end
        end
    end
end

function relation_scan_function()
end

function attribute_function(attr, layer)
end

function split(string, delimiter)
    local fields = {}
    for field in string:gmatch('([^' .. delimiter .. ']+)') do
        fields[#fields + 1] = field
    end
    return fields
end