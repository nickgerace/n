#!/usr/bin/env bash
SCRIPT_DIR=$(
  cd "$(dirname "${BASH_SOURCE[0]}")" &&
  pwd -P
) || exit 1
echo "$SCRIPT_DIR"
