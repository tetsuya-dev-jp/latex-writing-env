#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

build_dir="$WORKSPACE_DIR/build"

[ -d "$build_dir" ] || exit 0

rm -rf "$build_dir"
