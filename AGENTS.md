# Claude, Codex, Agents, etc.

## Source Control, Version Control, VCS, etc.

- For VCS, source control, etc. tasks, only use `jj` and do not use `git`
- You can use `gh` for GitHub-related work, but not `git` (only `jj`)
- Do not push or fetch commits, branches, tags, etc. unless permitted
- Do not edit commits
- Default to making all edits in the working copy and do not squash unless permitted
  - Do not edit commits directly to work around this

### Solving Conflicts

Only when you are explicitly told to solve conflicts can you squash.
You can only squash changes that are solely to solve conflicts, and again, you can only do that if you were explicitly told to solve conflicts.

## Interacting with Issue Trackers (e.g. Linear, GitHub)

- Do not create comments
- Do not edit comments
- Do not delete comments
- Do not create descriptions of issues, comments, projects, etc.
- Do not edit descriptions of issues, comments, projects, etc.
- Do not delete descriptions of issues, comments, etc.
- Do not resolve comments or mutate the state of comments in any way
- Do not resolve issues or mutate the state of issues in any way
- Do not resolve projects or mutate the state of projects in any way
- Never pose as the author

Using issue trackers is effectively read-only for you.
The only exceptions are the following, and they must be explicit:

- You can only change the dependency chain of an issue unless explicitly permitted (e.g. "issue A blocks issue B and both block issue C")
- You only file issues if explicitly permitted
  - When doing so, you can only say "<AGENT>'s notes:" (e.g. "Claude's notes:" or "Codex's notes") followed by a quote block with your contents.

## Interacting with Code Review platforms (e.g. GitHub)

- Do not create comments
- Do not edit comments
- Do not delete comments
- Do not create descriptions of pull requests, comments, etc.
- Do not edit descriptions of pull requests, comments, etc.
- Do not delete descriptions of pull requests, comments, etc.
- Do not resolve comments or mutate the state of comments in any way
- Do not close pull requests or mutate the state of pull requests in any way
- Never pose as the author

Interacting with code review should be read only.
No exceptions.

If the user ever says "address comments", "review comments", "work on comments" or any similar ambiguous language, this does not permit you to actually use the code review platform in any capacity behind read only operations.
All of those phrases refer to solely working in the jj working copy for any additions, mutations or deletions of source code.

## Code and Comments

### Rust

- Prefer functions and functional approaches over object-oriented ones
- If the crate uses "thiserror" for error enums and you need to create an error, use it and use "#[source]" if possible in the variant
- If you find yourself needing a named loop because we have nested loops, that is a smell that we need to break it out into another function
- Put as little logic in `tokio::select!` blocks as possible and call functions as needed (the functions themselves can have a lot of logic, but for readability, the select block should be small)
- Do not re-export items (you can rely on `pub`, `pub(crate)` and private scoping)

### Comments in Code, Scripts, Manifests, Text files, Config files, etc.

- Do not add comments
- Do not modify comments
- Do not remove comments
- If you would have done anything with comments, let me know because I may want to manually add one
- Anytime you see a comment starting with "START(nick):", that means it is where I'd like to pick up where I left off in the change, commit, and/or file

## Reviewing Changes

There is a baseline at all times when reviewing changes.
This must always be true unless otherwise specified.

Then, there is a secondary reviewer mode.
This mode is to focus on the specific concepts on top of the baseline.
Do not activate secondary reviewer mode unless explicitly told to do so.
You can ask the user if they'd like you to run in secondary reviewer mode.

### Baseline

- When asked to review changes, you are a principal engineer and software architect
- Look for good and _idiomatic_ patterns
- Be comprehensive and take your time
- Do not make any modifications

### Secondary Reviewer Mode

When explicitly told, run in secondary reviwer mode.
This mode means that, on top of the baseline, you have a rigorous focus on the following:

- code clarity
- abstraction quality
- dependency structuring
- API breakage
- regression analysis
- test coherence
- performance
- security
- edge case handling
