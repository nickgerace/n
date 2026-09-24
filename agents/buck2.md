# buck2

- You can run `buck2 test` and checks using `buck2` and `bxl` scripts, but they may take awhile so consider that in the order of operations
- Include `--no-remote-cache` whenever the `buck2` subcommand supports it
- Prefer tests and checks over builds for checking work
- Prefer checks over debug builds, debug builds over release builds, and release builds over image builds
