import sys
import subprocess
import re
import collections
import os

def aggregate_tags(input_file, output_file):
    print(f"Extracting and filtering seamark:* tags from {input_file} ...")
    
    # We use osmium cat to get XML, then process line by line
    # Command: osmium cat "$INPUT" -f osm
    
    cmd = ['osmium', 'cat', input_file, '-f', 'osm']
    try:
        process = subprocess.Popen(cmd, stdout=subprocess.PIPE, encoding='utf-8', errors='replace')
    except FileNotFoundError:
        print("Error: 'osmium' command not found. Please ensure osmium-tool is installed.")
        sys.exit(1)
    
    counts = collections.defaultdict(int)
    values = collections.defaultdict(lambda: collections.defaultdict(int))
    valcounts = collections.defaultdict(int)
    
    # Regex to extract key and value
    # XML line format: <tag k="seamark:type" v="buoy_lateral"/>
    tag_pattern = re.compile(r'k="(seamark:[^"]*)"\s+v="([^"]*)"')
    
    for line in process.stdout:
        if 'k="seamark:' in line:
            match = tag_pattern.search(line)
            if match:
                key = match.group(1)
                val = match.group(2)
                
                counts[key] += 1
                
                if key != "seamark:type":
                    # Numeric check
                    if re.match(r'^[0-9]+(\.[0-9]+)?$', val):
                        val = "<numeric>"
                    elif ';' in val:
                        val = "<list>"
                
                if val not in values[key]:
                    values[key][val] = 1
                    valcounts[key] += 1

    process.wait()
    
    print("Aggregating seamark:* keys and values ...")
    
    results = []
    for k, count in counts.items():
        n = count
        vals_list = []
        shown = 0
        
        sorted_vals = sorted(values[k].keys())
        
        for v in sorted_vals:
            if k == "seamark:type" or shown < 20:
                vals_list.append(v)
            else:
                vals_list.append("...")
                break
            shown += 1
            
        vals_str = ",".join(vals_list)
        results.append((n, k, vals_str))
    
    # Sort by count descending
    results.sort(key=lambda x: x[0], reverse=True)
    
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("count,key,values\n")
        for n, k, vals in results:
            f.write(f"{n},{k},{vals}\n")
            
    print(f"✅ Done. Output written to {output_file}")

if __name__ == "__main__":
    input_pbf = sys.argv[1] if len(sys.argv) > 1 else "../osm/seamarks.osm.pbf"
    output_csv = sys.argv[2] if len(sys.argv) > 2 else "seamark_tags.csv"
    aggregate_tags(input_pbf, output_csv)
