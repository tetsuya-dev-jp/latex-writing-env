#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

require_file_arg "$@"

target_path="$(normalize_path "$1")"
target_relative="$(workspace_relative "$target_path")"

case "$target_relative" in
  documents/*) ;;
  *) die "target must be inside documents/" ;;
esac

case "$target_relative" in
  *.tex) ;;
  *) die "target must be a .tex file" ;;
esac

bash "$SCRIPT_DIR/resolve-root.sh" "$1" >/dev/null

docker_run env NODE_PATH=/opt/textlint/node_modules \
  /opt/textlint/node_modules/.bin/textlint \
  --fix \
  --config /workspace/.textlintrc.json \
  "/workspace/$target_relative"
