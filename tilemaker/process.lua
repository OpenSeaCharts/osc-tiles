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
        end,
        anchor_berth = function()
            Layer("anchor_berth", false)
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
        end,
        anchor_berth = function()
            Layer("anchor_berth", true)
        end,
        berth = function()
            Layer("berth", true)
        end,
        bridge = function()
            Layer("bridge", true)
        end,
        bunker_station = function()
            Layer("bunker_station", true)
        end,
        building = function()
            Layer("building", true)
        end,
        cable_area = function()
            Layer("cable_area", true)
        end,
        harbour = function()
            Layer("harbour", true)
        end,
        recommended_route_centreline = function()
            Layer("recommended_route_centreline", false)
        end,
        recommended_track = function()
            Layer("recommended_track", false)
        end,
        recommended_traffic_lane = function()
            Layer("recommended_traffic_lane", false)
        end,
        restricted_area = function()
            Layer("restricted_area", true)
        end,
        sand_waves = function()
            Layer("sand_waves", true)
        end,
        sea_area = function()
            Layer("sea_area", true)
        end,
        seaplane_landing_area = function()
            Layer("seaplane_landing_area", true)
        end,
        wall = function()
            Layer("wall", false)
        end,
        weed = function()
            Layer("weed", true)
        end,
        wreck = function()
            Layer("wreck", true)
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