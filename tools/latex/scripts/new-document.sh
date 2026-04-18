#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

template_name="${TEMPLATE:-}"
document_name="${NAME:-}"

[ -n "$template_name" ] || die "TEMPLATE is required"
[ -n "$document_name" ] || die "NAME is required"

case "$document_name" in
  *[!A-Za-z0-9_-]*)
    die "NAME must contain only letters, numbers, hyphens, and underscores"
    ;;
esac

template_dir="$WORKSPACE_DIR/templates/$template_name"
target_dir="$WORKSPACE_DIR/documents/$document_name"

[ -d "$template_dir" ] || die "template not found: $template_name"
[ ! -e "$target_dir" ] || die "document already exists: $document_name"

mkdir -p "$target_dir"
cp -R "$template_dir/." "$target_dir"

document_title="$(printf '%s' "$document_name" | tr -- '-_' '  ')"

DOC_NAME="$document_name" DOC_TITLE="$document_title" \
perl -0pi -e 's/\@\@DOC_NAME\@\@/$ENV{DOC_NAME}/g; s/\@\@DOC_TITLE\@\@/$ENV{DOC_TITLE}/g' \
  "$target_dir/document.json" \
  "$target_dir/thesis.tex"

root_file="$(sed -n 's/.*"root"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' "$target_dir/document.json")"
[ -n "$root_file" ] || die "root is missing in generated document.json"

printf '%s\n' "documents/$document_name/$root_file"
