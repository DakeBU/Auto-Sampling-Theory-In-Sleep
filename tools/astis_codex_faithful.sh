#!/usr/bin/env bash
set -euo pipefail

root="${1:?usage: astis_codex_faithful.sh ROOT PROMPT}"
prompt="${2:?usage: astis_codex_faithful.sh ROOT PROMPT}"

cd "$root"

codex exec \
  --skip-git-repo-check \
  --dangerously-bypass-approvals-and-sandbox \
  -C "$root" \
  - < "$prompt"

