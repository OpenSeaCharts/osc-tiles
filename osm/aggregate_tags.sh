#!/usr/bin/env bash
set -euo pipefail

INPUT=${1:-seamarks.osm.pbf}
OUTPUT=${2:-seamark_tags.csv}

echo "Extracting and filtering seamark:* tags from $INPUT ..."

# 1️⃣ Extract key/value pairs where key starts with seamark:
osmium cat "$INPUT" -f osm | \
grep 'k="seamark:' | \
sed -n 's/.*k="\([^"]*\)".*v="\([^"]*\)".*/\1\t\2/p' > tags_tmp.tsv

echo "Aggregating seamark:* keys and values ..."

# 2️⃣ Aggregate with awk, applying value limit rule
awk -F'\t' '
{
  key=$1
  val=$2
  count[key]++
  if (!(val in values[key])) {
    values[key][val]=1
    valcount[key]++
  }
}
END {
  print "count,key,values"
  for (k in count) {
    n = count[k]
    num_vals = valcount[k]
    vals=""
    sep=""
    shown=0
    for (v in values[k]) {
      if (shown < 10 || num_vals <= 30) {
        vals = vals sep v
        sep = ","
      }
      shown++
    }
    if (num_vals > 30) {
      vals = vals ",..."
    }
    print n "," k "," vals
  }
}
' tags_tmp.tsv | sort -t, -k1,1nr > "$OUTPUT"

rm -f tags_tmp.tsv
echo "✅ Done. Output written to $OUTPUT"
