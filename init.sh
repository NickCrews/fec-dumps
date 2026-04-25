#!/bin/bash
set -euo pipefail
cargo install --git https://github.com/NickCrews/pg_dumpster --rev 1d3128abe68c6e375aee28fe55e543747f965467
uv tool install "huggingface_hub[cli]"