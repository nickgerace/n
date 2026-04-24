#!/usr/bin/env bash
set -euo pipefail

OWNER="nickgerace"
LIMIT="1000"

if ! command -v gh >/dev/null 2>&1; then
  echo "error: 'gh' is required" >&2
  exit 1
fi

if ! gh auth status >/dev/null 2>&1; then
  echo "error: 'gh' is not authenticated (run 'gh auth login' first)" >&2
  exit 1
fi

gh repo list "$OWNER" \
  --limit "$LIMIT" \
  --source \
  --json name,visibility \
  --jq '
    def repo_names($visibility):
      [.[] | select(.visibility == $visibility) | .name] | sort | .[];

    "== PRIVATE ==",
    repo_names("PRIVATE"),
    "",
    "== PUBLIC ==",
    repo_names("PUBLIC")
  '
