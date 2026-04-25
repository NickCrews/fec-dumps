#!/bin/bash
# Usage: ./process-table.sh <src> <table_name> [working_path]
# eg ./process-table.sh a "disclosure"."fec_fitem_sched_a_1975_1976"
# Assumes you are already logged in to Hugging Face CLI (hf auth login)
# or have set the HF_TOKEN environment variable.
set -euo pipefail

SRC=$(./get-url.sh "$1")
TABLE_NAME=$2
DEFAULT_OUTPUT="parquets/$TABLE_NAME.parquet"
OUTPUT=${3:-$DEFAULT_OUTPUT}
HF_REPO=${HF_REPO:-NickCrews/fec-dumps}
FILE_NAME="$TABLE_NAME.parquet"

echo "Reading table $TABLE_NAME from $SRC and writing to $OUTPUT..."
pg_dumpster table read "$SRC" "$TABLE_NAME" --format parquet --output "$OUTPUT"

echo "Uploading $OUTPUT to https://huggingface.co/datasets/$HF_REPO"
hf upload "$HF_REPO" "$OUTPUT" "$FILE_NAME" --repo-type=dataset --commit-message "Update $FILE_NAME"
echo "Done!"