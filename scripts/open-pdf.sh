#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# shellcheck source=common.sh
source "$SCRIPT_DIR/common.sh"

require_file_arg "$@"
eval "$(bash "$SCRIPT_DIR/resolve-root.sh" "$1")"

pdf_relative="$(document_build_dir "$DOC_DIR")/${ROOT%.tex}.pdf"
pdf_path="$WORKSPACE_DIR/$pdf_relative"

[ -f "$pdf_path" ] || die "pdf not found: $pdf_path"
command -v wslpath >/dev/null || die "wslpath is required to open PDFs from WSL"
command -v powershell.exe >/dev/null || die "powershell.exe is required to open PDFs in Windows"

win_pdf_path="$(wslpath -w "$pdf_path")"

powershell.exe -NoProfile -Command '& { param([string]$PdfPath) $candidates = @("$env:LOCALAPPDATA\SumatraPDF\SumatraPDF.exe", "$env:ProgramFiles\SumatraPDF\SumatraPDF.exe", "${env:ProgramFiles(x86)}\SumatraPDF\SumatraPDF.exe"); $sumatra = $candidates | Where-Object { $_ -and (Test-Path $_) } | Select-Object -First 1; if (-not $sumatra) { $command = Get-Command SumatraPDF.exe -ErrorAction SilentlyContinue; if ($command) { $sumatra = $command.Source } }; if (-not $sumatra) { throw "SumatraPDF.exe not found. Install SumatraPDF or add it to PATH." }; Start-Process -FilePath $sumatra -ArgumentList @("-reuse-instance", $PdfPath) }' "$win_pdf_path"
