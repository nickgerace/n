# kubectl

- When running or providing `kubectl` commands, always include the context explicitly (`--context <CONTEXT>`), so a command is never run against whichever cluster happens to be the current context
- Put the command and subcommand immediately after `kubectl`, before flags, so command permission rules match
