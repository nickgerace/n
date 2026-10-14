#!/usr/bin/env bash
set -euo pipefail

command -v jj >/dev/null 2>&1 || exit 0
command -v jq >/dev/null 2>&1 || exit 0

input="$(cat)"
[[ -z "$(jq -r '.session_title // empty' <<<"$input")" ]] || exit 0
cd "$(jq -r '.cwd' <<<"$input")"

root="$(jj --ignore-working-copy workspace root 2>/dev/null)" || exit 0
workspaces="$(jj --ignore-working-copy workspace list \
  -T 'json({"name" => name, "root" => root}) ++ "\n"' \
  2>/dev/null)" || exit 0

hash="$(jq -r '.session_id[:8]' <<<"$input")"

jq -s --arg root "$root" --arg repo "${root##*/}" --arg hash "$hash" '
  (if length == 1 then $repo
   else .[] | select(.root == $root) | .name
   end + "-" + $hash) as $title |
  {hookSpecificOutput: {
    hookEventName: "SessionStart",
    sessionTitle: $title
  }}
' <<<"$workspaces"
