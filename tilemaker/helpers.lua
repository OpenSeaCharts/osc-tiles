-- Helper functions for OpenSeaCharts tilemaker process

-- Global configuration
node_keys = { "seamark:type" }
way_keys = { "seamark:type" }

function init_function(name)
end

function exit_function()
end

function split(string, delimiter)
    local fields = {}
    for field in string:gmatch("([^" .. delimiter .. "]+)") do
        fields[#fields + 1] = field
    end
    return fields
end

function node_function() 
    process_seamark(false, false) 
end

function way_function() 
    process_seamark(true, IsClosed()) 
end
