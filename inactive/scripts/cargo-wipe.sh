#!/usr/bin/env bash
set -eu

while IFS= read -r -d '' CARGO_DOT_TOML; do
  if [ -f "$CARGO_DOT_TOML" ]; then
    CRATE=$(dirname "$CARGO_DOT_TOML")
    TARGET=$CRATE/target
    BASENAME=$(basename "$CRATE")
    if [ -d "$TARGET" ]; then
      SIZE=$(du -hs "$TARGET")
      read -r -n1 -p "Run \"cargo clean\" for $BASENAME? ($SIZE) [y/n]: " yn </dev/tty
      echo ""
      if [ "$yn" = "y" ]; then
        echo "Cleaning $BASENAME..."
        pushd "$CRATE"
        pwd
        cargo clean
        popd
      fi
    fi
  fi
done < <(find ~/src -type f -name Cargo.toml -print0)
