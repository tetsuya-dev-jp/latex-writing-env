#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

require_file_arg "$@"
eval "$(bash "$SCRIPT_DIR/resolve-root.sh" "$1")"

docker_run_in "/workspace/$DOC_DIR" chktex -q -l /workspace/tools/latex/.chktexrc "$ROOT"
