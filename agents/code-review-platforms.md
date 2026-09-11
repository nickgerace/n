# Interacting with Code Review platforms (e.g. GitHub)

Code review platforms are read-only for you, with no exceptions.
You may read pull requests, diffs, review threads and comments (e.g. with `gh pr view`, `gh pr diff` and `gh api` GET requests) to inform your local work.

- Do not create, edit or delete comments
- Do not create, edit or delete pull requests or their titles and descriptions
- Do not resolve comments, request or submit reviews, or mutate the state of comments in any way
- Do not close, merge, reopen or otherwise mutate the state of pull requests
- Never pose as the author

Phrases like "address comments", "review comments" or "work on comments" do not permit any write operation on the platform.
They mean: read the comments, then make the corresponding additions, modifications or deletions to source code in the jj working copy.
