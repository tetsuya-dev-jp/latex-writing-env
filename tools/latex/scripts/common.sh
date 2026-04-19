#!/usr/bin/env bash
set -euo pipefail

LATEX_IMAGE_NAME="${LATEX_IMAGE_NAME:-latex-writing-env:local}"
WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

die() {
  printf '%s\n' "$*" >&2
  exit 1
}

require_file_arg() {
  if [ "$#" -lt 1 ] || [ -z "${1:-}" ]; then
    die "FILE argument is required"
  fi
}

normalize_path() {
  realpath "$1"
}

workspace_relative() {
  local target_path="$1"
  case "$target_path" in
    "$WORKSPACE_DIR")
      printf '.'
      ;;
    "$WORKSPACE_DIR"/*)
      printf '%s' "${target_path#"$WORKSPACE_DIR/"}"
      ;;
    *)
      die "path must be inside workspace: $target_path"
      ;;
  esac
}

document_build_dir() {
  local doc_dir_relative="$1"

  case "$doc_dir_relative" in
    documents/*)
      printf 'build/%s' "${doc_dir_relative#documents/}"
      ;;
    *)
      die "document path must be inside documents/: $doc_dir_relative"
      ;;
  esac
}

docker_run() {
  docker run --rm \
    --user "$(id -u):$(id -g)" \
    -e HOME=/tmp \
    -v "$WORKSPACE_DIR:/workspace" \
    -w /workspace \
    "$LATEX_IMAGE_NAME" "$@"
}

docker_run_in() {
  local workdir="$1"
  shift
  docker run --rm \
    --user "$(id -u):$(id -g)" \
    -e HOME=/tmp \
    -v "$WORKSPACE_DIR:/workspace" \
    -w "$workdir" \
    "$LATEX_IMAGE_NAME" "$@"
}
