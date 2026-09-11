# buck2

- Never run `buck2 build`, `buck2 check` or `buck2 test` yourself
  - Instead, give the exact command to the user to run
  - Include `--no-remote-cache` whenever the command supports it
- Prefer checks over debug builds, debug builds over release builds, and release builds over image builds
