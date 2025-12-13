import csv
import re
import json
import sys
import os

def generate_config(csv_file, config_file, lua_file):
    print(f"Analyzing {csv_file}...")
    
    seamark_types = set()
    type_attributes = {}

    # 1. Read seamark types
    try:
        with open(csv_file, 'r', encoding='utf-8') as f:
            reader = csv.reader(f)
            for row in reader:
                if not row: continue
                key = row[1]
                if key == 'seamark:type':
                    for val in row[2:]:
                        if val and val != '...':
                            # Fix common issues: capitalization and spaces
                            val = val.lower().replace(' ', '_')

                            # Validation logic
                            # 1. Must not contain invalid chars
                            if any(c in val for c in [':', '=', ';', ',']):
                                continue
                            
                            # 3. Whitelist of allowed types/prefixes
                            # Based on OpenSeaMap data model
                            allowed_prefixes = [
                                'buoy', 'beacon', 'light', 'landmark', 'notice', 'gate', 'lock', 'bridge', 
                                'cable', 'pipeline', 'obstruction', 'wreck', 'rock', 'pilot', 'signal', 
                                'small_craft', 'harbour', 'mooring', 'ferry', 
                                'navigation', 'rescue', 'coastguard', 'marine', 'production', 'sea', 
                                'distance', 'recommended', 'radar', 'radio', 'separation', 'dredged', 
                                'dumping', 'military', 'restricted', 'precautionary', 'submarine', 
                                'water', 'weed', 'sand', 'vegetation', 'vehicle', 'tank', 'platform', 
                                'pylon', 'gridiron', 'hulk', 'fishing', 'fortified', 'exceptional', 
                                'fairway', 'causeway', 'checkpoint', 'anchor', 'turning', 'shoreline', 
                                'seaplane', 'seabed', 'retro', 'leading', 'protected', 'bunker', 
                                'boat', 'waterway', 'pile', 'pole', 'dry', 'floating', 'fog', 'top'
                            ]
                            
                            allowed_exact = [
                                'anchorage', 'berth', 'mooring', 'harbour', 'lock', 'gate', 'bridge', 
                                'obstruction', 'wreck', 'rock', 'landmark', 'platform', 'pylon', 'tank', 
                                'hulk', 'gridiron', 'fairway', 'causeway', 'checkpoint', 'weed', 
                                'seagrass', 'sand_waves', 'spring', 'water_turbulence', 'turning_basin', 
                                'dry_dock', 'pile', 'pole', 'waterway_gauge', 'boat_hoist', 'bunker_station',
                                'sunken_ship', 'hazard', 'conveyor', 'sea', 'notice'
                            ]

                            is_allowed = False
                            if val in allowed_exact:
                                is_allowed = True
                            else:
                                for p in allowed_prefixes:
                                    if val.startswith(p + '_') or val == p:
                                        is_allowed = True
                                        break
                            
                            if not is_allowed:
                                continue

                            seamark_types.add(val)
                    break
    except FileNotFoundError:
        print(f"Error: {csv_file} not found.")
        return

    # 2. Read attributes
    with open(csv_file, 'r', encoding='utf-8') as f:
        reader = csv.reader(f)
        for row in reader:
            if not row: continue
            key = row[1]
            match = re.match(r'seamark:([^:]+):(.+)', key)
            if match:
                t = match.group(1)
                attr = match.group(2)
                if t in seamark_types:
                    if t not in type_attributes:
                        type_attributes[t] = set()
                    type_attributes[t].add(attr)

    # 3. Group types
    groups = {}
    for t in seamark_types:
        if '_' in t:
            prefix = t.split('_')[0]
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

    # 4. Generate config.json snippet
    new_layers = {}
    for g in groups:
        new_layers[g] = {"minzoom": 8, "maxzoom": 12}

    # Update config.json
    if os.path.exists(config_file):
        with open(config_file, 'r') as f:
            config = json.load(f)
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

    # Remove layers that are no longer in the groups (cleanup)
    # But be careful not to remove non-seamark layers if any exist.
    # For now, we just update/add.
    # To clean up "dolohin" etc from config, we might need to remove keys that are not in new_layers
    # IF we assume config only contains seamark layers.
    # Let's try to remove keys that look like seamark layers but are not in new_layers?
    # Or just overwrite the 'layers' section if we are confident?
    # The user said "my tile schema should have every seamark type as a layer".
    # Let's assume we manage all layers.
    
    # Actually, let's just remove the specific bad ones we know about if they exist, 
    # or better, rebuild the layers list if we want to be clean.
    # Given the previous instructions, we are building the config from scratch-ish.
    # Let's clear the layers that we know are seamarks but not in our new list?
    # Or just replace config['layers'] with new_layers?
    # That's risky if there are other layers.
    # But the user asked to "do some clean up".
    # Let's replace config['layers'] with new_layers.
    config['layers'] = new_layers

    for k, v in new_layers.items():
        config['layers'][k] = v

    with open(config_file, 'w') as f:
        json.dump(config, f, indent=2)
    
    print(f"Updated {config_file}")

    # 5. Generate process.lua
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
        lua_code.append(f'            Layer("{group}", {is_area})')
        lua_code.append(f'            Attribute("type", "{t}")')
        
        if t in type_attributes:
            for attr in sorted(list(type_attributes[t])):
                attr_name = attr.replace(':', '_')
                lua_code.append(f'            Attribute("{attr_name}", Find("seamark:{t}:{attr}"))')
                
        lua_code.append('            Attribute("name", Find("seamark:name"))')
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
    csv_path = sys.argv[1] if len(sys.argv) > 1 else "seamark_tags.csv"
    config_path = sys.argv[2] if len(sys.argv) > 2 else "../tilemaker/config.json"
    lua_path = sys.argv[3] if len(sys.argv) > 3 else "../tilemaker/process.lua"
    
    generate_config(csv_path, config_path, lua_path)
