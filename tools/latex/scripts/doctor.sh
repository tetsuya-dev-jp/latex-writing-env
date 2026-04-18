#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

docker info >/dev/null
docker_run latexmk -v >/dev/null
docker_run uplatex --version >/dev/null
docker_run pbibtex --version >/dev/null
docker_run dvipdfmx --version >/dev/null
eval "$(bash "$SCRIPT_DIR/resolve-root.sh" "$WORKSPACE_DIR/documents/example-paper/thesis.tex")"

while IFS= read -r bib_file; do
  [ -n "$bib_file" ] || continue
  [ -f "$WORKSPACE_DIR/$DOC_DIR/$bib_file" ] || die "bibliography file not found: $DOC_DIR/$bib_file"
done < <(json_array_field "$WORKSPACE_DIR/$DOC_DIR/document.json" bib)

printf 'doctor: ok\n'
