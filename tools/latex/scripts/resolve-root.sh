#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

require_file_arg "$@"

target_path="$(normalize_path "$1")"
workspace_documents="$WORKSPACE_DIR/documents"

case "$target_path" in
  "$workspace_documents"/*) ;;
  *) die "target must be inside documents/" ;;
esac

if [ -f "$target_path" ]; then
  doc_dir="$(dirname "$target_path")"
else
  doc_dir="$target_path"
fi

while [ "$doc_dir" != "$WORKSPACE_DIR" ] && [ ! -f "$doc_dir/document.json" ]; do
  doc_dir="$(dirname "$doc_dir")"
done

[ -f "$doc_dir/document.json" ] || die "document.json not found"

root_relative="$(sed -n 's/.*"root"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$doc_dir/document.json")"
output_relative="$(sed -n 's/.*"output"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$doc_dir/document.json")"

[ -n "$root_relative" ] || die "root is missing in document.json"
[ -n "$output_relative" ] || die "output is missing in document.json"

doc_dir_relative="$(workspace_relative "$doc_dir")"

printf 'DOC_DIR=%q\n' "$doc_dir_relative"
printf 'ROOT=%q\n' "$root_relative"
printf 'OUTPUT=%q\n' "$output_relative"
