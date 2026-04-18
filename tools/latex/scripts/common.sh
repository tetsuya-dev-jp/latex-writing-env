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

json_string_field() {
  local json_file="$1"
  local key="$2"
  local json_file_relative

  json_file_relative="$(workspace_relative "$(normalize_path "$json_file")")"

  docker_run perl -MJSON::PP -e '
    use strict;
    use warnings;

    my ($file, $key) = @ARGV;
    open my $fh, q{<}, $file or die qq{cannot open $file: $!\n};
    local $/;
    my $data = decode_json(<$fh>);
    my $value = $data->{$key};

    exit 0 if !defined $value;
    die qq{$key must be a string\n} if ref $value;

    print $value;
  ' "/workspace/$json_file_relative" "$key"
}

json_array_field() {
  local json_file="$1"
  local key="$2"
  local json_file_relative

  json_file_relative="$(workspace_relative "$(normalize_path "$json_file")")"

  docker_run perl -MJSON::PP -e '
    use strict;
    use warnings;

    my ($file, $key) = @ARGV;
    open my $fh, q{<}, $file or die qq{cannot open $file: $!\n};
    local $/;
    my $data = decode_json(<$fh>);
    my $value = $data->{$key};

    exit 0 if !defined $value;
    die qq{$key must be an array\n} if ref($value) ne q{ARRAY};

    for my $entry (@{$value}) {
      die qq{$key entries must be strings\n} if ref $entry;
      print qq{$entry\n};
    }
  ' "/workspace/$json_file_relative" "$key"
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
