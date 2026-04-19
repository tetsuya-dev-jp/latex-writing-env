#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

require_file_arg "$@"
eval "$(bash "$SCRIPT_DIR/resolve-root.sh" "$1")"

doc_name="$(basename "$DOC_DIR")"
out_dir_relative="build/$doc_name"
out_dir_absolute="$WORKSPACE_DIR/$out_dir_relative"
root_pdf_name="${ROOT%.tex}.pdf"
root_pdf_path="$out_dir_absolute/$root_pdf_name"
output_pdf_path="$out_dir_absolute/$OUTPUT"

mkdir -p "$out_dir_absolute"

docker_run_in "/workspace/$DOC_DIR" \
  latexmk \
  -pdfdvi \
  -interaction=nonstopmode \
  -file-line-error \
  -shell-escape \
  -outdir="/workspace/$out_dir_relative" \
  -e '$latex=q/uplatex %O -synctex=1 %S/;' \
  -e '$bibtex=q/pbibtex %O %B/;' \
  -e '$dvipdf=q/dvipdfmx %O -o %D %S/;' \
  "$ROOT"

[ -f "$root_pdf_path" ] || die "expected pdf was not generated: $root_pdf_path"

if [ "$root_pdf_path" != "$output_pdf_path" ]; then
  cp "$root_pdf_path" "$output_pdf_path"
fi

printf '%s\n' "$out_dir_relative/$OUTPUT"
