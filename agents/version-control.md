# Source Control, Version Control, VCS, etc.

- For VCS, source control, etc. tasks, only use `jj` and do not use `git`
  - This includes read-only commands: use `jj log`, `jj diff` and `jj show` rather than their `git` equivalents
- You can use `gh` for GitHub-related work, but not `git` (only `jj`)
- Do not push or fetch commits, bookmarks, branches, tags, etc. unless permitted
- Do not edit commits
- Default to making all edits in the working copy and do not squash unless permitted
  - Do not edit commits directly to work around this

## Solving Conflicts

Only when you are explicitly told to solve conflicts can you squash.
You can only squash changes that are solely to solve conflicts, and again, you can only do that if you were explicitly told to solve conflicts.

## Splitting Changes

- When splitting a change, each change needs to be individually landable/mergeable, but they can be dependent on their descendants in a stack

## Describing, Naming and Titling Commits

- You can only describe commits with a title that is <=50 characters
- Some repositories need a prefix in the format "<domain>: " and others do not, so check recent titles with `jj log` and match what the repository already does
