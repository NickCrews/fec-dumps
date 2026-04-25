#!/bin/bash
# Usage: ./process-table.sh <src> <table_name> [working_path]
# eg ./process-table.sh a "disclosure"."fec_fitem_sched_a_1975_1976"
SRC=$(./get-url.sh "$1")
TABLE_NAME=$2
DEFAULT_OUTPUT="parquets/$TABLE_NAME.parquet"
OUTPUT=${3:-$DEFAULT_OUTPUT}

echo "Reading table $TABLE_NAME from $SRC and writing to $OUTPUT..."
pg_dumpster table read "$SRC" "$TABLE_NAME" --format parquet --output "$OUTPUT"
FILE_NAME="$TABLE_NAME.parquet"
echo "Uploading $OUTPUT to GitHub release https://github.com/NickCrews/fec-dump-parquets/releases/tag/latest"
gh release delete-asset latest "$FILE_NAME" --yes || true # Ignore error if asset doesn't exist
# Before the # is the file path, and after the # is the name of the file in the release.
gh release upload latest "$OUTPUT#$FILE_NAME"
echo "Done!"