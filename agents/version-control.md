# Source Control, Version Control, VCS, etc.

- For VCS, source control, etc. tasks, only use `jj` and do not use `git`
  - This includes read-only commands: use `jj log`, `jj diff` and `jj show` rather than their `git` equivalents
- You can use `gh` for GitHub-related work, but not `git` (only `jj`)
- Do not push or fetch commits, bookmarks, branches, tags, etc. unless permitted
- Do not edit commits
- Default to making all edits in the working copy and do not squash unless permitted
  - Do not edit commits directly to work around this

## Solving Conflicts

Squash only when explicitly told to solve conflicts, and only changes that exist solely to resolve those conflicts.

## Splitting Changes

- When splitting a change, each change needs to be individually landable/mergeable, but it can depend on its ancestors in the stack

## Describing, Naming and Titling Commits

- You can only describe commits with a title that is <=50 characters
- Some repositories need a prefix in the format "<domain>: " and others do not, so check recent titles with `jj log` and match what the repository already does
