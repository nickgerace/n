# Claude, Codex, Agents, etc.

## Source Control, Version Control, VCS, etc.

- For VCS, source control, etc. tasks, only use `jj` and do not use `git`
- You can use `gh` for GitHub-related work, but not `git` (only `jj`)
- Do not push or fetch commits, branches, tags, etc. unless permitted
- Default to making all edits in the working copy and do not squash unless permitted

## Rust

- Prefer functions and functional approaches over object-oriented ones
- If the crate uses "thiserror" for error enums and you need to create an error, use it and use "#[source]" if possible in the variant
- If you find yourself needing a named loop because we have nested loops, that is a smell that we need to break it out into another function
- Put as little logic in `tokio::select!` blocks as possible and call functions as needed (the functions themselves can have a lot of logic, but for readability, the select block should be small)
- Do not re-export items (you can rely on `pub`, `pub(crate)` and private scoping)

## Comments in Code, Scripts, Manifests, Text files, Config files, etc.

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
