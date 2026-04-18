#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

if [ "$#" -lt 1 ] || [ -z "${1:-}" ]; then
  build_dir="$WORKSPACE_DIR/build"
  [ -d "$build_dir" ] || exit 0
  find "$build_dir" -type f ! -name '*.pdf' -delete
  exit 0
fi

eval "$(bash "$SCRIPT_DIR/resolve-root.sh" "$1")"

doc_name="$(basename "$DOC_DIR")"
build_dir="$WORKSPACE_DIR/build/$doc_name"

[ -d "$build_dir" ] || exit 0

find "$build_dir" -type f ! -name '*.pdf' -delete
