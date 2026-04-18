#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

require_file_arg "$@"

target_path="$(normalize_path "$1")"
target_relative="$(workspace_relative "$target_path")"

docker_run latexindent -w -l=/workspace/tools/latex/.latexindent.yaml "/workspace/$target_relative"
