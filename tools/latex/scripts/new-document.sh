#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

document_name="${NAME:-}"

[ -n "$document_name" ] || die "NAME is required"

case "$document_name" in
  *[!A-Za-z0-9_-]*)
    die "NAME must contain only letters, numbers, hyphens, and underscores"
    ;;
esac

target_dir="$WORKSPACE_DIR/documents/$document_name"

[ ! -e "$target_dir" ] || die "document already exists: $document_name"

mkdir -p "$target_dir/chapters"

document_title="$(printf '%s' "$document_name" | tr -- '-_' '  ')"

cat <<EOF > "$target_dir/main.tex"
\\documentclass[uplatex,dvipdfmx]{jsreport}

\\usepackage{graphicx}
\\usepackage{booktabs}

\\title{$document_title}
\\author{Tetsuya}
\\date{\\today}

\\begin{document}

\\maketitle
\\tableofcontents

\\input{chapters/introduction}

\\bibliographystyle{jplain}
\\bibliography{refs}

\\end{document}
EOF

cat <<'EOF' > "$target_dir/chapters/introduction.tex"
\chapter{Introduction}

This document was created by latex-writing-env.

It also includes a bibliography example~\cite{lamport1994latex}.
EOF

cat <<'EOF' > "$target_dir/refs.bib"
@book{lamport1994latex,
  author    = {Leslie Lamport},
  title     = {LaTeX: A Document Preparation System},
  year      = {1994},
  publisher = {Addison-Wesley}
}
EOF

printf '%s\n' "documents/$document_name/main.tex"
