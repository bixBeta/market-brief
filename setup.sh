#!/usr/bin/env bash
# One-time setup: create bixBeta/market-brief on GitHub, push, and enable Pages.
set -euo pipefail
cd "$(dirname "$0")"

gh auth status >/dev/null 2>&1 || { echo "gh is not logged in. Run: gh auth login"; exit 1; }

if [ ! -d .git ]; then
  git init -q -b main
  git add -A
  git commit -q -m "Add market brief dashboard and first brief (2026-10-06)"
fi

if gh repo view bixBeta/market-brief >/dev/null 2>&1; then
  echo "Repo already exists; pushing."
  git remote get-url origin >/dev/null 2>&1 || git remote add origin "https://github.com/bixBeta/market-brief.git"
  git push -u origin main
else
  gh repo create bixBeta/market-brief --public \
    --description "Daily US stock market pre-open brief dashboard" \
    --source=. --remote=origin --push
fi

# Enable GitHub Pages from main / root (ignore error if already enabled)
gh api -X POST repos/bixBeta/market-brief/pages \
  -f "source[branch]=main" -f "source[path]=/" >/dev/null 2>&1 \
  && echo "GitHub Pages enabled." || echo "Pages already enabled or needs a manual toggle."

echo "Done: https://github.com/bixBeta/market-brief"
echo "Dashboard (live in ~1 min): https://bixbeta.github.io/market-brief/"
