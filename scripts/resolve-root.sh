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

while [ "$doc_dir" != "$workspace_documents" ] && [ ! -f "$doc_dir/main.tex" ]; do
  doc_dir="$(dirname "$doc_dir")"
done

[ -f "$doc_dir/main.tex" ] || die "main.tex not found"

doc_dir_relative="$(workspace_relative "$doc_dir")"

printf 'DOC_DIR=%q\n' "$doc_dir_relative"
printf 'ROOT=%q\n' 'main.tex'
