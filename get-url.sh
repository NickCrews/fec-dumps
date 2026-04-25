#!/bin/bash
# Map from the friendly names "a" and "b" to the corresponding S3 URLs, or use the provided argument as a path to a local file.
SRC=$1
SCHED_A_URL=https://cg-519a459a-0ea3-42c2-b7bc-fa1143481f74.s3-us-gov-west-1.amazonaws.com/bulk-downloads/data-dump/schedules/fec_fitem_sched_a.dump
SCHED_B_URL=https://cg-519a459a-0ea3-42c2-b7bc-fa1143481f74.s3-us-gov-west-1.amazonaws.com/bulk-downloads/data-dump/schedules/fec_fitem_sched_b.dump
# If src="a" or "b", use the corresponding URL. Otherwise, assume src is a path to a local file.
if [ "$SRC" == "a" ]; then
    SRC=$SCHED_A_URL
elif [ "$SRC" == "b" ]; then
    SRC=$SCHED_B_URL
fi
echo "$SRC"