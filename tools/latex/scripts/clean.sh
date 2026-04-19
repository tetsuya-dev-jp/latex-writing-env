#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

if [ "$#" -lt 1 ] || [ -z "${1:-}" ]; then
  build_dir="$WORKSPACE_DIR/build"
  [ -d "$build_dir" ] || exit 0
  rm -rf "$build_dir"
  exit 0
fi

eval "$(bash "$SCRIPT_DIR/resolve-root.sh" "$1")"

build_dir="$WORKSPACE_DIR/$(document_build_dir "$DOC_DIR")"

[ -d "$build_dir" ] || exit 0

rm -rf "$build_dir"
