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
bash "$SCRIPT_DIR/resolve-root.sh" "$WORKSPACE_DIR/documents/example-paper/thesis.tex" >/dev/null

printf 'doctor: ok\n'
