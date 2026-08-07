# Rust

- Prefer functions and functional approaches over object-oriented ones
- If the crate uses "thiserror" for error enums and you need to create an error, use it and use "#[source]" if possible in the variant
- If you find yourself needing a named loop because we have nested loops, that is a smell that we need to break it out into another function
- Put as little logic in `tokio::select!` blocks as possible and call functions as needed (the functions themselves can have a lot of logic, but for readability, the select block should be small)
- Do not re-export items (you can rely on `pub`, `pub(crate)` and private scoping)
