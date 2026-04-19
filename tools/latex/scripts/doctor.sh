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
eval "$(bash "$SCRIPT_DIR/resolve-root.sh" "$WORKSPACE_DIR/documents/example-paper/main.tex")"

printf 'doctor: ok\n'
