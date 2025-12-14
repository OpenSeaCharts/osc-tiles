function init_function(name) end
function exit_function() end
node_keys = { "seamark:type" }
way_keys = { "seamark:type" }

function split(string, delimiter)
    local fields = {}
    for field in string:gmatch("([^" .. delimiter .. "]+)") do
        fields[#fields + 1] = field
    end
    return fields
end

function process_seamark(is_way, is_closed)
    local type = Find("seamark:type")
    if type == "" then return end
    type = string.lower(type)
    type = string.gsub(type, " ", "_")

    local handlers = {
        ["anchorage"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("anchorage", is_area)
                Attribute("type", "anchorage")
                Attribute("id", Id())
                Attribute("category", Find("seamark:anchorage:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["anchor_berth"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("anchor_berth", is_area)
                Attribute("type", "anchor_berth")
                Attribute("id", Id())
                Attribute("category", Find("seamark:anchor_berth:category"))
                Attribute("radius", Find("seamark:anchor_berth:radius"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["beacon_lateral"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("beacon", is_area)
                Attribute("type", "beacon_lateral")
                Attribute("id", Id())
                Attribute("category", Find("seamark:beacon_lateral:category"))
                Attribute("colour", Find("seamark:beacon_lateral:colour"))
                Attribute("colourPattern", Find("seamark:beacon_lateral:colour_pattern"))
                Attribute("shape", Find("seamark:beacon_lateral:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["beacon_cardinal"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("beacon", is_area)
                Attribute("type", "beacon_cardinal")
                Attribute("id", Id())
                Attribute("category", Find("seamark:beacon_cardinal:category"))
                Attribute("colour", Find("seamark:beacon_cardinal:colour"))
                Attribute("colourPattern", Find("seamark:beacon_cardinal:colour_pattern"))
                Attribute("shape", Find("seamark:beacon_cardinal:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["beacon_isolated_danger"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("beacon", is_area)
                Attribute("type", "beacon_isolated_danger")
                Attribute("id", Id())
                Attribute("category", Find("seamark:beacon_isolated_danger:category"))
                Attribute("colour", Find("seamark:beacon_isolated_danger:colour"))
                Attribute("colourPattern", Find("seamark:beacon_isolated_danger:colour_pattern"))
                Attribute("shape", Find("seamark:beacon_isolated_danger:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["beacon_safe_water"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("beacon", is_area)
                Attribute("type", "beacon_safe_water")
                Attribute("id", Id())
                Attribute("category", Find("seamark:beacon_safe_water:category"))
                Attribute("colour", Find("seamark:beacon_safe_water:colour"))
                Attribute("colourPattern", Find("seamark:beacon_safe_water:colour_pattern"))
                Attribute("shape", Find("seamark:beacon_safe_water:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["beacon_special_purpose"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("beacon", is_area)
                Attribute("type", "beacon_special_purpose")
                Attribute("id", Id())
                Attribute("category", Find("seamark:beacon_special_purpose:category"))
                Attribute("colour", Find("seamark:beacon_special_purpose:colour"))
                Attribute("colourPattern", Find("seamark:beacon_special_purpose:colour_pattern"))
                Attribute("shape", Find("seamark:beacon_special_purpose:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["beacon"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("beacon", is_area)
                Attribute("type", "beacon")
                Attribute("id", Id())
                Attribute("category", Find("seamark:beacon:category"))
                Attribute("colour", Find("seamark:beacon:colour"))
                Attribute("colourPattern", Find("seamark:beacon:colour_pattern"))
                Attribute("shape", Find("seamark:beacon:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["berth"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
                if not output then
                    output = true
                    is_area = false
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("berth", is_area)
                Attribute("type", "berth")
                Attribute("id", Id())
                Attribute("minimumDepth", Find("seamark:berth:minimum_depth"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["bridge"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
                if not output then
                    output = true
                    is_area = false
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("bridge", is_area)
                Attribute("type", "bridge")
                Attribute("id", Id())
                Attribute("category", Find("seamark:bridge:category"))
                Attribute("clearanceHeight", Find("seamark:bridge:clearance_height"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["building"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
                if not output then
                    output = true
                    is_area = false
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("building", is_area)
                Attribute("type", "building")
                Attribute("id", Id())
                Attribute("function", Find("seamark:building:function"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["bunker_station"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
                if not output then
                    output = true
                    is_area = false
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("bunker_station", is_area)
                Attribute("type", "bunker_station")
                Attribute("id", Id())
                Attribute("category", Find("seamark:bunker_station:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["buoy_lateral"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("buoy", is_area)
                Attribute("type", "buoy_lateral")
                Attribute("id", Id())
                Attribute("category", Find("seamark:buoy_lateral:category"))
                Attribute("colour", Find("seamark:buoy_lateral:colour"))
                Attribute("colourPattern", Find("seamark:buoy_lateral:colour_pattern"))
                Attribute("shape", Find("seamark:buoy_lateral:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["buoy_cardinal"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("buoy", is_area)
                Attribute("type", "buoy_cardinal")
                Attribute("id", Id())
                Attribute("category", Find("seamark:buoy_cardinal:category"))
                Attribute("colour", Find("seamark:buoy_cardinal:colour"))
                Attribute("colourPattern", Find("seamark:buoy_cardinal:colour_pattern"))
                Attribute("shape", Find("seamark:buoy_cardinal:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["buoy_isolated_danger"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("buoy", is_area)
                Attribute("type", "buoy_isolated_danger")
                Attribute("id", Id())
                Attribute("category", Find("seamark:buoy_isolated_danger:category"))
                Attribute("colour", Find("seamark:buoy_isolated_danger:colour"))
                Attribute("colourPattern", Find("seamark:buoy_isolated_danger:colour_pattern"))
                Attribute("shape", Find("seamark:buoy_isolated_danger:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["buoy_safe_water"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("buoy", is_area)
                Attribute("type", "buoy_safe_water")
                Attribute("id", Id())
                Attribute("category", Find("seamark:buoy_safe_water:category"))
                Attribute("colour", Find("seamark:buoy_safe_water:colour"))
                Attribute("colourPattern", Find("seamark:buoy_safe_water:colour_pattern"))
                Attribute("shape", Find("seamark:buoy_safe_water:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["buoy_special_purpose"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("buoy", is_area)
                Attribute("type", "buoy_special_purpose")
                Attribute("id", Id())
                Attribute("category", Find("seamark:buoy_special_purpose:category"))
                Attribute("colour", Find("seamark:buoy_special_purpose:colour"))
                Attribute("colourPattern", Find("seamark:buoy_special_purpose:colour_pattern"))
                Attribute("shape", Find("seamark:buoy_special_purpose:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["buoy_installation"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("buoy", is_area)
                Attribute("type", "buoy_installation")
                Attribute("id", Id())
                Attribute("category", Find("seamark:buoy_installation:category"))
                Attribute("colour", Find("seamark:buoy_installation:colour"))
                Attribute("colourPattern", Find("seamark:buoy_installation:colour_pattern"))
                Attribute("shape", Find("seamark:buoy_installation:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["buoy"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("buoy", is_area)
                Attribute("type", "buoy")
                Attribute("id", Id())
                Attribute("category", Find("seamark:buoy:category"))
                Attribute("colour", Find("seamark:buoy:colour"))
                Attribute("colourPattern", Find("seamark:buoy:colour_pattern"))
                Attribute("shape", Find("seamark:buoy:shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["cable_area"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
            end
            if output then
                Layer("cable_area", is_area)
                Attribute("type", "cable_area")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["cable_overhead"] = function()
            local output = false
            local is_area = false
            if is_way then
                output = true
                is_area = false
            else
            end
            if output then
                Layer("cable_overhead", is_area)
                Attribute("type", "cable_overhead")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["cable_submarine"] = function()
            local output = false
            local is_area = false
            if is_way then
                output = true
                is_area = false
            else
            end
            if output then
                Layer("cable_submarine", is_area)
                Attribute("type", "cable_submarine")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["checkpoint"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("checkpoint", is_area)
                Attribute("type", "checkpoint")
                Attribute("id", Id())
                Attribute("category", Find("seamark:checkpoint:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["coastguard_station"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("coastguard_station", is_area)
                Attribute("type", "coastguard_station")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["crane"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("crane", is_area)
                Attribute("type", "crane")
                Attribute("id", Id())
                Attribute("category", Find("seamark:crane:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["daymark"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("daymark", is_area)
                Attribute("type", "daymark")
                Attribute("id", Id())
                Attribute("category", Find("seamark:daymark:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["distance_mark"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("distance_mark", is_area)
                Attribute("type", "distance_mark")
                Attribute("id", Id())
                Attribute("category", Find("seamark:distance_mark:category"))
                Attribute("distance", Find("seamark:distance_mark:distance"))
                Attribute("units", Find("seamark:distance_mark:units"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["dredged_area"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
            end
            if output then
                Layer("sea_area", is_area)
                Attribute("type", "dredged_area")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["dumping_ground"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
            end
            if output then
                Layer("sea_area", is_area)
                Attribute("type", "dumping_ground")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["fairway"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
                if not output then
                    output = true
                    is_area = false
                end
            else
            end
            if output then
                Layer("fairway", is_area)
                Attribute("type", "fairway")
                Attribute("id", Id())
                Attribute("restriction", Find("seamark:fairway:restriction"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["ferry_route"] = function()
            local output = false
            local is_area = false
            if is_way then
                output = true
                is_area = false
            else
            end
            if output then
                Layer("ferry_route", is_area)
                Attribute("type", "ferry_route")
                Attribute("id", Id())
                Attribute("category", Find("seamark:ferry_route:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["wall"] = function()
            local output = false
            local is_area = false
            if is_way then
                output = true
                is_area = false
            else
            end
            if output then
                Layer("wall", is_area)
                Attribute("type", "wall")
                Attribute("id", Id())
                Attribute("category", Find("seamark:wall:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["fog_signal"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("fog_signal", is_area)
                Attribute("type", "fog_signal")
                Attribute("id", Id())
                Attribute("category", Find("seamark:fog_signal:category"))
                Attribute("frequency", Find("seamark:fog_signal:frequency"))
                Attribute("generation", Find("seamark:fog_signal:generation"))
                Attribute("group", Find("seamark:fog_signal:group"))
                Attribute("period", Find("seamark:fog_signal:period"))
                Attribute("range", Find("seamark:fog_signal:range"))
                Attribute("sequence", Find("seamark:fog_signal:sequence"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["fortified_structure"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("fortified_structure", is_area)
                Attribute("type", "fortified_structure")
                Attribute("id", Id())
                Attribute("category", Find("seamark:fortified_structure:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["fishing_facility"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("fishing_facility", is_area)
                Attribute("type", "fishing_facility")
                Attribute("id", Id())
                Attribute("category", Find("seamark:fishing_facility:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["gate"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
                if not output then
                    output = true
                    is_area = false
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("gate", is_area)
                Attribute("type", "gate")
                Attribute("id", Id())
                Attribute("category", Find("seamark:gate:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["gridiron"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("gridiron", is_area)
                Attribute("type", "gridiron")
                Attribute("id", Id())
                Attribute("waterLevel", Find("seamark:gridiron:water_level"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["harbour_basin"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
            end
            if output then
                Layer("harbour_basin", is_area)
                Attribute("type", "harbour_basin")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["harbour"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("harbour", is_area)
                Attribute("type", "harbour")
                Attribute("id", Id())
                Attribute("category", Find("seamark:harbour:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["hulk"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("hulk", is_area)
                Attribute("type", "hulk")
                Attribute("id", Id())
                Attribute("category", Find("seamark:hulk:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["landmark"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("landmark", is_area)
                Attribute("type", "landmark")
                Attribute("id", Id())
                Attribute("category", Find("seamark:landmark:category"))
                Attribute("colour", Find("seamark:landmark:colour"))
                Attribute("colourPattern", Find("seamark:landmark:colour_pattern"))
                Attribute("function", Find("seamark:landmark:function"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["light"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                local colours = Find("seamark:light:colour")
                if colours ~= "" and string.find(colours, ";") then
                    local colour_list = split(colours, ";")
                    for _, c in ipairs(colour_list) do
                        Layer("light", is_area)
                        Attribute("type", "light")
                        Attribute("id", Id())
                        Attribute("category", Find("seamark:light:category"))
                        Attribute("colour", c)
                        Attribute("name", Find("seamark:name"))
                    end
                else
                Layer("light", is_area)
                Attribute("type", "light")
                Attribute("id", Id())
                Attribute("category", Find("seamark:light:category"))
                Attribute("colour", Find("seamark:light:colour"))
                Attribute("name", Find("seamark:name"))
                end
            end
        end,
        ["light_major"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("light_major", is_area)
                Attribute("type", "light_major")
                Attribute("id", Id())
                Attribute("category", Find("seamark:light_major:category"))
                Attribute("character", Find("seamark:light_major:character"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["light_minor"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("light_minor", is_area)
                Attribute("type", "light_minor")
                Attribute("id", Id())
                Attribute("category", Find("seamark:light_minor:category"))
                Attribute("character", Find("seamark:light_minor:character"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["light_float"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("light_float", is_area)
                Attribute("type", "light_float")
                Attribute("id", Id())
                Attribute("colour", Find("seamark:light_float:colour"))
                Attribute("colourPattern", Find("seamark:light_float:colour_pattern"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["light_vessel"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("light_vessel", is_area)
                Attribute("type", "light_vessel")
                Attribute("id", Id())
                Attribute("colour", Find("seamark:light_vessel:colour"))
                Attribute("colourPattern", Find("seamark:light_vessel:colour_pattern"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["marine_farm"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("marine_farm", is_area)
                Attribute("type", "marine_farm")
                Attribute("id", Id())
                Attribute("category", Find("seamark:marine_farm:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["mooring"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("mooring", is_area)
                Attribute("type", "mooring")
                Attribute("id", Id())
                Attribute("category", Find("seamark:mooring:category"))
                Attribute("colour", Find("seamark:mooring:colour"))
                Attribute("colourPattern", Find("seamark:mooring:colour_pattern"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["navigation_line"] = function()
            local output = false
            local is_area = false
            if is_way then
                output = true
                is_area = false
            else
            end
            if output then
                Layer("navigation_line", is_area)
                Attribute("type", "navigation_line")
                Attribute("id", Id())
                Attribute("category", Find("seamark:navigation_line:category"))
                Attribute("orientation", Find("seamark:navigation_line:orientation"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["notice"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("notice", is_area)
                Attribute("type", "notice")
                Attribute("id", Id())
                Attribute("category", Find("seamark:notice:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["obstruction"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("obstruction", is_area)
                Attribute("type", "obstruction")
                Attribute("id", Id())
                Attribute("category", Find("seamark:obstruction:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["platform"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("platform", is_area)
                Attribute("type", "platform")
                Attribute("id", Id())
                Attribute("category", Find("seamark:platform:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["production_area"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
            end
            if output then
                Layer("production_area", is_area)
                Attribute("type", "production_area")
                Attribute("id", Id())
                Attribute("category", Find("seamark:production_area:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["pilot_boarding"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("pilot_boarding", is_area)
                Attribute("type", "pilot_boarding")
                Attribute("id", Id())
                Attribute("category", Find("seamark:pilot_boarding:category"))
                Attribute("channel", Find("seamark:pilot_boarding:channel"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["pile"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("pile", is_area)
                Attribute("type", "pile")
                Attribute("id", Id())
                Attribute("category", Find("seamark:pile:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["radar_reflector"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("radar_reflector", is_area)
                Attribute("type", "radar_reflector")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["recommended_track"] = function()
            local output = false
            local is_area = false
            if is_way then
                output = true
                is_area = false
            else
            end
            if output then
                Layer("recommended_track", is_area)
                Attribute("type", "recommended_track")
                Attribute("id", Id())
                Attribute("orientation", Find("seamark:recommended_track:orientation"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["rescue_station"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("rescue_station", is_area)
                Attribute("type", "rescue_station")
                Attribute("id", Id())
                Attribute("category", Find("seamark:rescue_station:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["restricted_area"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
            end
            if output then
                Layer("restricted_area", is_area)
                Attribute("type", "restricted_area")
                Attribute("id", Id())
                Attribute("category", Find("seamark:restricted_area:category"))
                Attribute("restriction", Find("seamark:restricted_area:restriction"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["seaplane_landing_area"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
            end
            if output then
                Layer("seaplane_landing_area", is_area)
                Attribute("type", "seaplane_landing_area")
                Attribute("id", Id())
                Attribute("restriction", Find("seamark:seaplane_landing_area:restriction"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["signal_station_warning"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("signal_station", is_area)
                Attribute("type", "signal_station_warning")
                Attribute("id", Id())
                Attribute("category", Find("seamark:signal_station_warning:category"))
                Attribute("channel", Find("seamark:signal_station_warning:channel"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["signal_station_traffic"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("signal_station", is_area)
                Attribute("type", "signal_station_traffic")
                Attribute("id", Id())
                Attribute("category", Find("seamark:signal_station_traffic:category"))
                Attribute("channel", Find("seamark:signal_station_traffic:channel"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["small_craft_facility"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("small_craft_facility", is_area)
                Attribute("type", "small_craft_facility")
                Attribute("id", Id())
                Attribute("category", Find("seamark:small_craft_facility:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["spring"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("spring", is_area)
                Attribute("type", "spring")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["topmark"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("topmark", is_area)
                Attribute("type", "topmark")
                Attribute("id", Id())
                Attribute("colour", Find("seamark:topmark:colour"))
                Attribute("colourPattern", Find("seamark:topmark:colour_pattern"))
                Attribute("shape", Find("seamark:topmark:shape"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["separation_lane"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
            end
            if output then
                Layer("separation_lane", is_area)
                Attribute("type", "separation_lane")
                Attribute("id", Id())
                Attribute("category", Find("seamark:separation_lane:category"))
                Attribute("restriction", Find("seamark:separation_lane:restriction"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["separation_line"] = function()
            local output = false
            local is_area = false
            if is_way then
                output = true
                is_area = false
            else
            end
            if output then
                Layer("separation_line", is_area)
                Attribute("type", "separation_line")
                Attribute("id", Id())
                Attribute("category", Find("seamark:separation_line:category"))
                Attribute("orientation", Find("seamark:separation_line:orientation"))
                Attribute("restriction", Find("seamark:separation_line:restriction"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["separation_roundabout"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
            end
            if output then
                Layer("separation_roundabout", is_area)
                Attribute("type", "separation_roundabout")
                Attribute("id", Id())
                Attribute("category", Find("seamark:separation_roundabout:category"))
                Attribute("restriction", Find("seamark:separation_roundabout:restriction"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["separation_zone"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
            end
            if output then
                Layer("separation_zone", is_area)
                Attribute("type", "separation_zone")
                Attribute("id", Id())
                Attribute("category", Find("seamark:separation_zone:category"))
                Attribute("restriction", Find("seamark:separation_zone:restriction"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["rock"] = function()
            local output = false
            local is_area = false
            if is_way then
            else
                output = true
                is_area = false
            end
            if output then
                Layer("rock", is_area)
                Attribute("type", "rock")
                Attribute("id", Id())
                Attribute("waterLevel", Find("seamark:rock:water_level"))
                Attribute("name", Find("seamark:name"))
            end
        end,
        ["wreck"] = function()
            local output = false
            local is_area = false
            if is_way then
                if is_closed or Find("area") == "yes" then
                    output = true
                    is_area = true
                end
            else
                output = true
                is_area = false
            end
            if output then
                Layer("wreck", is_area)
                Attribute("type", "wreck")
                Attribute("id", Id())
                Attribute("category", Find("seamark:wreck:category"))
                Attribute("name", Find("seamark:name"))
            end
        end,
    }

    if handlers[type] then
        handlers[type]()
    end
end

function node_function() process_seamark(false, false) end
function way_function() process_seamark(true, IsClosed()) end