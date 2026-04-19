#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

require_file_arg "$@"
eval "$(bash "$SCRIPT_DIR/resolve-root.sh" "$1")"

out_dir_relative="build/$DOC_DIR"
out_dir_absolute="$WORKSPACE_DIR/$out_dir_relative"

mkdir -p "$out_dir_absolute"

docker_run_in "/workspace/$DOC_DIR" \
  latexmk \
  -pdfdvi \
  -pvc \
  -view=none \
  -interaction=nonstopmode \
  -file-line-error \
  -shell-escape \
  -outdir="/workspace/$out_dir_relative" \
  -e '$latex=q/uplatex %O -synctex=1 %S/;' \
  -e '$bibtex=q/pbibtex %O %B/;' \
  -e '$dvipdf=q/dvipdfmx %O -o %D %S/;' \
  "$ROOT"
