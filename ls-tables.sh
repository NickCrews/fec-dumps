#!/bin/bash
SRC=$(./get-url.sh "$1")
DEFAULT_FORMAT="plain"
FORMAT=${2:-$DEFAULT_FORMAT}
RAW=$(pg_dumpster table ls "$SRC")
if [ "$FORMAT" == "plain" ]; then
    # print as one per line, eg
    # "disclosure"."fec_fitem_sched_a_1975_1976"
    # "disclosure"."fec_fitem_sched_b_1977_1978"
    # ...
    echo "Tables in $SRC:"
    echo "$RAW"
elif [ "$FORMAT" == "json" ]; then
    # print as eg ["\"disclosure\".\"fec_fitem_sched_a_1975_1976\"", "\"disclosure\".\"fec_fitem_sched_b_1977_1978\"", ...]
    echo "$RAW" | jq -R -s -c 'split("\n")[:-1]'
else
    echo "Unsupported format: $FORMAT. Supported formats are 'plain' and 'json'."
    exit 1
fi