#!/usr/bin/env bash
# Installs the ECC plugin's npm dependencies when the plugin cache lacks them.
# Claude Code installs ECC without running npm, and its session-start hook
# crashes on `Cannot find module 'js-yaml'` until these are present.
base="${1:-$HOME/.claude/plugins/cache/ecc/ecc}"
for d in "$base"/*/; do
  [ -f "$d/package.json" ] || continue
  [ -d "$d/node_modules/js-yaml" ] && continue
  (cd "$d" && npm install --omit=dev --ignore-scripts --no-audit --no-fund --silent)
done
exit 0
