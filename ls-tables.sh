#!/bin/bash
SRC=$(./get-url.sh "$1")
pg_dumpster table ls "$SRC"