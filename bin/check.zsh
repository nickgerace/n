#!/usr/bin/env zsh
for file in **/*.zsh(N) zshrc; do
  zsh -n "$file" || exit 1
done
shellcheck **/*.sh(N)
