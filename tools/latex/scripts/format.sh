#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

require_file_arg "$@"

target_path="$(normalize_path "$1")"
target_relative="$(workspace_relative "$target_path")"
temp_relative="${target_relative}.format-tmp"

rm -f "$WORKSPACE_DIR/$temp_relative"

docker_run sh -lc "latexindent -g=/tmp/indent.log -l=/workspace/tools/latex/.latexindent.yaml \"/workspace/$target_relative\" > \"/workspace/$temp_relative\""

mv "$WORKSPACE_DIR/$temp_relative" "$target_path"
