$env.PATH = ($env.PATH | append "~/.cargo/bin")

source "~/.cargo/env.nu"

alias cargo-check-all = cargo check --all-targets --all-features
