import re
import json
import sys
import os

def generate_config_from_schema(schema_file, config_file, lua_file):
    print(f"Reading schema from {schema_file}...")
    
    seamark_types = set()
    type_attributes = {}
    
    current_type = None
    stack = [] # List of (indent_level, name)

    try:
        with open(schema_file, 'r', encoding='utf-8') as f:
            for line in f:
                line = line.rstrip()
                if not line: continue
                
                # Detect indentation (2 spaces per level)
                indent = len(line) - len(line.lstrip())
                content = line.strip()
                
                # Match item: - **name**...
                match = re.match(r'- \*\*(.+?)\*\*', content)
                if match:
                    name = match.group(1)
                    
                    # Manage stack
                    while stack and stack[-1][0] >= indent:
                        stack.pop()
                    stack.append((indent, name))
                    
                    if len(stack) == 1:
                        # Top level: Seamark Type
                        current_type = name
                        seamark_types.add(current_type)
                        type_attributes[current_type] = set()
                    else:
                        # Attribute
                        if current_type:
                            # Construct attribute path relative to type
                            # stack[0] is type. stack[1:] are attributes.
                            attr_parts = [x[1] for x in stack[1:]]
                            attr_name = ":".join(attr_parts)
                            type_attributes[current_type].add(attr_name)
                            
    except FileNotFoundError:
        print(f"Error: {schema_file} not found.")
        return

    print(f"Found {len(seamark_types)} seamark types.")

    # Group types
    groups = {}
    for t in seamark_types:
        if '_' in t:
            prefix = t.split('_')[0]
            # Common prefixes that should be grouped
            if prefix in ['buoy', 'beacon', 'light', 'bridge', 'gate', 'lock', 'mooring', 'pipeline', 'cable', 'separation', 'signal', 'radio', 'rescue', 'radar', 'coastguard', 'marine', 'production', 'sea', 'obstruction', 'wreck', 'rock', 'landmark', 'notice', 'distance', 'small', 'ferry', 'navigation', 'recommended', 'pilot']:
                 group = prefix
            else:
                 group = t
        else:
            group = t
            
        if t.startswith('small_craft_facility'): group = 'small_craft_facility'
        if t.startswith('distance_mark'): group = 'distance_mark'
        if t.startswith('pilot_boarding'): group = 'pilot_boarding'
        
        if group not in groups:
            groups[group] = []
        groups[group].append(t)

    # Generate config.json snippet
    new_layers = {}
    for g in groups:
        new_layers[g] = {"minzoom": 8, "maxzoom": 12}

    # Update config.json
    if os.path.exists(config_file):
        with open(config_file, 'r') as f:
            try:
                config = json.load(f)
            except json.JSONDecodeError:
                config = {"layers": {}}
    else:
        config = {"layers": {}}

    if 'layers' not in config:
        config['layers'] = {}

    # Update tilejson version
    if 'settings' not in config:
        config['settings'] = {}
    
    if 'filemetadata' not in config['settings']:
        config['settings']['filemetadata'] = {}
        
    config['settings']['filemetadata']['tilejson'] = "3.0.0"

    # Replace layers with generated ones
    config['layers'] = new_layers

    with open(config_file, 'w') as f:
        json.dump(config, f, indent=2)
    
    print(f"Updated {config_file}")

    # Generate process.lua
    lua_code = []
    lua_code.append('function init_function(name)')
    lua_code.append('end')
    lua_code.append('')
    lua_code.append('function exit_function()')
    lua_code.append('end')
    lua_code.append('')
    lua_code.append('node_keys = { "seamark:type" }')
    lua_code.append('way_keys = { "seamark:type" }')
    lua_code.append('')
    lua_code.append('function split(string, delimiter)')
    lua_code.append('    local fields = {}')
    lua_code.append('    for field in string:gmatch("([^" .. delimiter .. "]+)") do')
    lua_code.append('        fields[#fields + 1] = field')
    lua_code.append('    end')
    lua_code.append('    return fields')
    lua_code.append('end')
    lua_code.append('')
    lua_code.append('function process_seamark(is_way)')
    lua_code.append('    local type = Find("seamark:type")')
    lua_code.append('    if type == "" then return end')
    lua_code.append('    type = string.lower(type)')
    lua_code.append('    type = string.gsub(type, " ", "_")')
    lua_code.append('')
    lua_code.append('    local handlers = {')

    for t in sorted(list(seamark_types)):
        group = None
        for g, types in groups.items():
            if t in types:
                group = g
                break
        
        # Infer geometry
        is_area = "false"
        if any(x in t for x in ['area', 'basin', 'zone', 'harbour', 'dock', 'lake', 'sea', 'ocean', 'bay', 'anchorage', 'berth', 'construction', 'farm', 'field', 'forest', 'grass', 'ground', 'island', 'land', 'marsh', 'meadow', 'mud', 'park', 'reef', 'reservoir', 'rock', 'sand', 'scrub', 'shoal', 'stone', 'water', 'wetland', 'wood', 'wreck']):
            is_area = "is_way" 
        
        if t in ['anchorage', 'anchor_berth', 'berth', 'bunker_station', 'causeway', 'checkpoint', 'coastguard_station', 'dredged_area', 'dumping_ground', 'exceptional_structure', 'fairway', 'fortified_structure', 'fishing_facility', 'gate', 'gridiron', 'harbour', 'harbour_basin', 'hulk', 'inshore_traffic_zone', 'landmark', 'lock_basin', 'marine_farm', 'military_area', 'mooring', 'obstruction', 'platform', 'production_area', 'pipeline_area', 'precautionary_area', 'pylon', 'radar_range', 'rescue_station', 'restricted_area', 'sand_waves', 'seabed_area', 'sea_area', 'seagrass', 'seaplane_landing_area', 'tank', 'shoreline_construction', 'submarine_transit_lane', 'separation_crossing', 'separation_roundabout', 'separation_zone', 'turning_basin', 'vegetation', 'vehicle_transfer', 'water_turbulence', 'weed', 'wreck']:
            is_area = "is_way"
        elif 'area' in t or 'zone' in t or 'basin' in t:
            is_area = "is_way"
        
        if t in ['cable_overhead', 'cable_submarine', 'pipeline_overhead', 'pipeline_submarine', 'navigation_line', 'recommended_track', 'recommended_traffic_lane', 'separation_line', 'separation_boundary', 'separation_lane', 'two-way_route', 'ferry_route', 'radar_line']:
            is_area = "false"

        lua_code.append(f'        ["{t}"] = function()')
        
        # Split attributes into base and numbered
        base_attrs = []
        numbered_attrs = {} # index -> list of (suffix, full_attr)
        
        if t in type_attributes:
            for attr in sorted(list(type_attributes[t])):
                parts = attr.split(':')
                if parts[0].isdigit():
                    idx = int(parts[0])
                    suffix = ':'.join(parts[1:])
                    if suffix: # Ensure not empty
                        if idx not in numbered_attrs: numbered_attrs[idx] = []
                        numbered_attrs[idx].append((suffix, attr))
                else:
                    base_attrs.append(attr)

        # Base Layer
        lua_code.append(f'            Layer("{group}", {is_area})')
        lua_code.append(f'            Attribute("type", "{t}")')
        
        for attr in base_attrs:
            attr_name = attr.replace(':', '_')
            lua_code.append(f'            Attribute("{attr_name}", Find("seamark:{t}:{attr}"))')
                
        lua_code.append('            Attribute("name", Find("seamark:name"))')

        # Numbered Layers (e.g. seamark:light:1:...)
        for idx in sorted(numbered_attrs.keys()):
            attrs = numbered_attrs[idx]
            # Condition: check if any attribute exists
            conditions = [f'Find("seamark:{t}:{full_attr}") ~= ""' for _, full_attr in attrs]
            
            lua_code.append(f'            if {" or ".join(conditions)} then')
            lua_code.append(f'                Layer("{group}", {is_area})')
            lua_code.append(f'                Attribute("type", "{t}")')
            
            for suffix, full_attr in attrs:
                attr_name = suffix.replace(':', '_')
                lua_code.append(f'                Attribute("{attr_name}", Find("seamark:{t}:{full_attr}"))')
            
            lua_code.append('                Attribute("name", Find("seamark:name"))')
            lua_code.append('            end')

        lua_code.append('        end,')

    lua_code.append('    }')
    lua_code.append('')
    lua_code.append('    if handlers[type] then')
    lua_code.append('        handlers[type]()')
    lua_code.append('    end')
    lua_code.append('end')
    lua_code.append('')
    lua_code.append('function node_function()')
    lua_code.append('    process_seamark(false)')
    lua_code.append('end')
    lua_code.append('')
    lua_code.append('function way_function()')
    lua_code.append('    process_seamark(true)')
    lua_code.append('end')

    with open(lua_file, 'w') as f:
        f.write('\n'.join(lua_code))
    
    print(f"Updated {lua_file}")

if __name__ == "__main__":
    schema_path = sys.argv[1] if len(sys.argv) > 1 else "seamark_hierarchy.md"
    config_path = sys.argv[2] if len(sys.argv) > 2 else "../tilemaker/config.json"
    lua_path = sys.argv[3] if len(sys.argv) > 3 else "../tilemaker/process.lua"
    
    generate_config_from_schema(schema_path, config_path, lua_path)
