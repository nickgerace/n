function claude-temp {
  cd $(mktemp -d)
  claude
}

function codex-temp {
  cd $(mktemp -d)
  codex
}
