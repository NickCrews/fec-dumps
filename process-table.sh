#!/bin/bash
DEFAULT_OUTPUT="parquets/$TABLE_NAME.parquet"

SRC=$(./get-url.sh "$1")
TABLE_NAME=$2
OUTPUT=${3:-$DEFAULT_OUTPUT}

pg_dumpster table read "$SRC" "$TABLE_NAME" --format parquet --output "$OUTPUT"