dofile("helpers.lua")

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
            local function emit(prefix)
                Layer("anchorage", is_area)
                Attribute("type", "anchorage")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:anchorage")
            for i=1,25 do
                local p = "seamark:anchorage:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("anchor_berth", is_area)
                Attribute("type", "anchor_berth")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("radius", Find(prefix .. ":radius"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:anchor_berth")
            for i=1,25 do
                local p = "seamark:anchor_berth:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":radius") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("beacon", is_area)
                Attribute("type", "beacon_lateral")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:beacon_lateral")
            for i=1,25 do
                local p = "seamark:beacon_lateral:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("beacon", is_area)
                Attribute("type", "beacon_cardinal")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:beacon_cardinal")
            for i=1,25 do
                local p = "seamark:beacon_cardinal:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("beacon", is_area)
                Attribute("type", "beacon_isolated_danger")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:beacon_isolated_danger")
            for i=1,25 do
                local p = "seamark:beacon_isolated_danger:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("beacon", is_area)
                Attribute("type", "beacon_safe_water")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:beacon_safe_water")
            for i=1,25 do
                local p = "seamark:beacon_safe_water:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("beacon", is_area)
                Attribute("type", "beacon_special_purpose")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:beacon_special_purpose")
            for i=1,25 do
                local p = "seamark:beacon_special_purpose:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("beacon", is_area)
                Attribute("type", "beacon")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:beacon")
            for i=1,25 do
                local p = "seamark:beacon:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("berth", is_area)
                Attribute("type", "berth")
                Attribute("id", Id())
                Attribute("minimumDepth", Find(prefix .. ":minimum_depth"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:berth")
            for i=1,25 do
                local p = "seamark:berth:" .. i
                if Find(p .. ":minimum_depth") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("bridge", is_area)
                Attribute("type", "bridge")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("clearanceHeight", Find(prefix .. ":clearance_height"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:bridge")
            for i=1,25 do
                local p = "seamark:bridge:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":clearance_height") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("building", is_area)
                Attribute("type", "building")
                Attribute("id", Id())
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:building")
            for i=1,25 do
                local p = "seamark:building:" .. i
                if Find(p .. ":function") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("bunker_station", is_area)
                Attribute("type", "bunker_station")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:bunker_station")
            for i=1,25 do
                local p = "seamark:bunker_station:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("buoy", is_area)
                Attribute("type", "buoy_lateral")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:buoy_lateral")
            for i=1,25 do
                local p = "seamark:buoy_lateral:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("buoy", is_area)
                Attribute("type", "buoy_cardinal")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:buoy_cardinal")
            for i=1,25 do
                local p = "seamark:buoy_cardinal:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("buoy", is_area)
                Attribute("type", "buoy_isolated_danger")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:buoy_isolated_danger")
            for i=1,25 do
                local p = "seamark:buoy_isolated_danger:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("buoy", is_area)
                Attribute("type", "buoy_safe_water")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:buoy_safe_water")
            for i=1,25 do
                local p = "seamark:buoy_safe_water:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("buoy", is_area)
                Attribute("type", "buoy_special_purpose")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:buoy_special_purpose")
            for i=1,25 do
                local p = "seamark:buoy_special_purpose:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("buoy", is_area)
                Attribute("type", "buoy_installation")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:buoy_installation")
            for i=1,25 do
                local p = "seamark:buoy_installation:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("buoy", is_area)
                Attribute("type", "buoy")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:buoy")
            for i=1,25 do
                local p = "seamark:buoy:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("cable_area", is_area)
                Attribute("type", "cable_area")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:cable_area")
            for i=1,25 do
                local p = "seamark:cable_area:" .. i
                if Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("cable_overhead", is_area)
                Attribute("type", "cable_overhead")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:cable_overhead")
            for i=1,25 do
                local p = "seamark:cable_overhead:" .. i
                if Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("cable_submarine", is_area)
                Attribute("type", "cable_submarine")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:cable_submarine")
            for i=1,25 do
                local p = "seamark:cable_submarine:" .. i
                if Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("checkpoint", is_area)
                Attribute("type", "checkpoint")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:checkpoint")
            for i=1,25 do
                local p = "seamark:checkpoint:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("coastguard_station", is_area)
                Attribute("type", "coastguard_station")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:coastguard_station")
            for i=1,25 do
                local p = "seamark:coastguard_station:" .. i
                if Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("crane", is_area)
                Attribute("type", "crane")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:crane")
            for i=1,25 do
                local p = "seamark:crane:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("daymark", is_area)
                Attribute("type", "daymark")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:daymark")
            for i=1,25 do
                local p = "seamark:daymark:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("distance_mark", is_area)
                Attribute("type", "distance_mark")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("distance", Find(prefix .. ":distance"))
                Attribute("units", Find(prefix .. ":units"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:distance_mark")
            for i=1,25 do
                local p = "seamark:distance_mark:" .. i
                if Find(p .. ":category") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("sea_area", is_area)
                Attribute("type", "dredged_area")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:dredged_area")
            for i=1,25 do
                local p = "seamark:dredged_area:" .. i
                if Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("sea_area", is_area)
                Attribute("type", "dumping_ground")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:dumping_ground")
            for i=1,25 do
                local p = "seamark:dumping_ground:" .. i
                if Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("fairway", is_area)
                Attribute("type", "fairway")
                Attribute("id", Id())
                Attribute("restriction", Find(prefix .. ":restriction"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:fairway")
            for i=1,25 do
                local p = "seamark:fairway:" .. i
                if Find(p .. ":restriction") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("ferry_route", is_area)
                Attribute("type", "ferry_route")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:ferry_route")
            for i=1,25 do
                local p = "seamark:ferry_route:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("wall", is_area)
                Attribute("type", "wall")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:wall")
            for i=1,25 do
                local p = "seamark:wall:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("fog_signal", is_area)
                Attribute("type", "fog_signal")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("frequency", Find(prefix .. ":frequency"))
                Attribute("generation", Find(prefix .. ":generation"))
                Attribute("group", Find(prefix .. ":group"))
                Attribute("period", Find(prefix .. ":period"))
                Attribute("range", Find(prefix .. ":range"))
                Attribute("sequence", Find(prefix .. ":sequence"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:fog_signal")
            for i=1,25 do
                local p = "seamark:fog_signal:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":range") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("fortified_structure", is_area)
                Attribute("type", "fortified_structure")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:fortified_structure")
            for i=1,25 do
                local p = "seamark:fortified_structure:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("fishing_facility", is_area)
                Attribute("type", "fishing_facility")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:fishing_facility")
            for i=1,25 do
                local p = "seamark:fishing_facility:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("gate", is_area)
                Attribute("type", "gate")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:gate")
            for i=1,25 do
                local p = "seamark:gate:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("gridiron", is_area)
                Attribute("type", "gridiron")
                Attribute("id", Id())
                Attribute("waterLevel", Find(prefix .. ":water_level"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:gridiron")
            for i=1,25 do
                local p = "seamark:gridiron:" .. i
                if Find(p .. ":water_level") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("harbour_basin", is_area)
                Attribute("type", "harbour_basin")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:harbour_basin")
            for i=1,25 do
                local p = "seamark:harbour_basin:" .. i
                if Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("harbour", is_area)
                Attribute("type", "harbour")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:harbour")
            for i=1,25 do
                local p = "seamark:harbour:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("hulk", is_area)
                Attribute("type", "hulk")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:hulk")
            for i=1,25 do
                local p = "seamark:hulk:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("landmark", is_area)
                Attribute("type", "landmark")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("function", string.gsub(string.gsub(type, "^beacon_", ""), "^buoy_", ""))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:landmark")
            for i=1,25 do
                local p = "seamark:landmark:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":function") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                local colours = Find(prefix .. ":colour")
                if colours ~= "" and string.find(colours, ";") then
                    local colour_list = split(colours, ";")
                    for _, c in ipairs(colour_list) do
                        Layer("light", is_area)
                        Attribute("type", "light")
                        Attribute("id", Id())
                        Attribute("category", Find(prefix .. ":category"))
                        Attribute("colour", c)
                        Attribute("name", Find("seamark:name"))
                    end
                else
                Layer("light", is_area)
                Attribute("type", "light")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("name", Find("seamark:name"))
                end
            end
            emit("seamark:light")
            for i=1,25 do
                local p = "seamark:light:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
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
            local function emit(prefix)
                Layer("light_major", is_area)
                Attribute("type", "light_major")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("character", Find(prefix .. ":character"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:light_major")
            for i=1,25 do
                local p = "seamark:light_major:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":character") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("light_minor", is_area)
                Attribute("type", "light_minor")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("character", Find(prefix .. ":character"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:light_minor")
            for i=1,25 do
                local p = "seamark:light_minor:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":character") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("light_float", is_area)
                Attribute("type", "light_float")
                Attribute("id", Id())
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:light_float")
            for i=1,25 do
                local p = "seamark:light_float:" .. i
                if Find(p .. ":colour") ~= "" or Find(p .. ":colour_pattern") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("light_vessel", is_area)
                Attribute("type", "light_vessel")
                Attribute("id", Id())
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:light_vessel")
            for i=1,25 do
                local p = "seamark:light_vessel:" .. i
                if Find(p .. ":colour") ~= "" or Find(p .. ":colour_pattern") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("marine_farm", is_area)
                Attribute("type", "marine_farm")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:marine_farm")
            for i=1,25 do
                local p = "seamark:marine_farm:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("mooring", is_area)
                Attribute("type", "mooring")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:mooring")
            for i=1,25 do
                local p = "seamark:mooring:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":colour") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("navigation_line", is_area)
                Attribute("type", "navigation_line")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("orientation", Find(prefix .. ":orientation"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:navigation_line")
            for i=1,25 do
                local p = "seamark:navigation_line:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":orientation") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("notice", is_area)
                Attribute("type", "notice")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:notice")
            for i=1,25 do
                local p = "seamark:notice:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("obstruction", is_area)
                Attribute("type", "obstruction")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:obstruction")
            for i=1,25 do
                local p = "seamark:obstruction:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("platform", is_area)
                Attribute("type", "platform")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:platform")
            for i=1,25 do
                local p = "seamark:platform:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("production_area", is_area)
                Attribute("type", "production_area")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:production_area")
            for i=1,25 do
                local p = "seamark:production_area:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("pilot_boarding", is_area)
                Attribute("type", "pilot_boarding")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("channel", Find(prefix .. ":channel"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:pilot_boarding")
            for i=1,25 do
                local p = "seamark:pilot_boarding:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":channel") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("pile", is_area)
                Attribute("type", "pile")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:pile")
            for i=1,25 do
                local p = "seamark:pile:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("radar_reflector", is_area)
                Attribute("type", "radar_reflector")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:radar_reflector")
            for i=1,25 do
                local p = "seamark:radar_reflector:" .. i
                if Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("recommended_track", is_area)
                Attribute("type", "recommended_track")
                Attribute("id", Id())
                Attribute("orientation", Find(prefix .. ":orientation"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:recommended_track")
            for i=1,25 do
                local p = "seamark:recommended_track:" .. i
                if Find(p .. ":orientation") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("rescue_station", is_area)
                Attribute("type", "rescue_station")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:rescue_station")
            for i=1,25 do
                local p = "seamark:rescue_station:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("restricted_area", is_area)
                Attribute("type", "restricted_area")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("restriction", Find(prefix .. ":restriction"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:restricted_area")
            for i=1,25 do
                local p = "seamark:restricted_area:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":restriction") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("seaplane_landing_area", is_area)
                Attribute("type", "seaplane_landing_area")
                Attribute("id", Id())
                Attribute("restriction", Find(prefix .. ":restriction"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:seaplane_landing_area")
            for i=1,25 do
                local p = "seamark:seaplane_landing_area:" .. i
                if Find(p .. ":restriction") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("signal_station", is_area)
                Attribute("type", "signal_station_warning")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("channel", Find(prefix .. ":channel"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:signal_station_warning")
            for i=1,25 do
                local p = "seamark:signal_station_warning:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":channel") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("signal_station", is_area)
                Attribute("type", "signal_station_traffic")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("channel", Find(prefix .. ":channel"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:signal_station_traffic")
            for i=1,25 do
                local p = "seamark:signal_station_traffic:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":channel") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("small_craft_facility", is_area)
                Attribute("type", "small_craft_facility")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:small_craft_facility")
            for i=1,25 do
                local p = "seamark:small_craft_facility:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("spring", is_area)
                Attribute("type", "spring")
                Attribute("id", Id())
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:spring")
            for i=1,25 do
                local p = "seamark:spring:" .. i
                if Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("topmark", is_area)
                Attribute("type", "topmark")
                Attribute("id", Id())
                Attribute("colour", Find(prefix .. ":colour"))
                Attribute("colourPattern", Find(prefix .. ":colour_pattern"))
                Attribute("shape", Find(prefix .. ":shape"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:topmark")
            for i=1,25 do
                local p = "seamark:topmark:" .. i
                if Find(p .. ":colour") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("separation_lane", is_area)
                Attribute("type", "separation_lane")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("restriction", Find(prefix .. ":restriction"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:separation_lane")
            for i=1,25 do
                local p = "seamark:separation_lane:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":restriction") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("separation_line", is_area)
                Attribute("type", "separation_line")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("orientation", Find(prefix .. ":orientation"))
                Attribute("restriction", Find(prefix .. ":restriction"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:separation_line")
            for i=1,25 do
                local p = "seamark:separation_line:" .. i
                if Find(p .. ":category") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("separation_roundabout", is_area)
                Attribute("type", "separation_roundabout")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("restriction", Find(prefix .. ":restriction"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:separation_roundabout")
            for i=1,25 do
                local p = "seamark:separation_roundabout:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":restriction") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("separation_zone", is_area)
                Attribute("type", "separation_zone")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("restriction", Find(prefix .. ":restriction"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:separation_zone")
            for i=1,25 do
                local p = "seamark:separation_zone:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":restriction") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("rock", is_area)
                Attribute("type", "rock")
                Attribute("id", Id())
                Attribute("waterLevel", Find(prefix .. ":water_level"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:rock")
            for i=1,25 do
                local p = "seamark:rock:" .. i
                if Find(p .. ":water_level") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
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
            local function emit(prefix)
                Layer("wreck", is_area)
                Attribute("type", "wreck")
                Attribute("id", Id())
                Attribute("category", Find(prefix .. ":category"))
                Attribute("name", Find("seamark:name"))
            end
            emit("seamark:wreck")
            for i=1,25 do
                local p = "seamark:wreck:" .. i
                if Find(p .. ":category") ~= "" or Find(p .. ":name") ~= "" or Find(p .. ":id") ~= "" then
                    emit(p)
                end
            end
            end
        end,
    }

    if handlers[type] then
        handlers[type]()
    end
end