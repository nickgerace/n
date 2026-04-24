#!/usr/bin/env bash
set -eu

. /etc/os-release
if [ "$(uname -s)" != "Linux" ] || [ "$(uname -m)" != "x86_64" ] || [ "$ID" != "arch" ]; then
  echo "Must be Arch Linux x86_64" >&2
  exit 1
fi

if [ -f /proc/sys/kernel/osrelease ] && grep "WSL2" /proc/sys/kernel/osrelease; then
  echo "Cannot run in WSL2" >&2
  exit 1
fi

if ! command -v php; then
  sudo pacman -S --noconfirm php
fi

if ! command -v phoronix-test-suite; then
  paru -S phoronix-test-suite
fi

if ! phoronix-test-suite list-installed-tests | grep -q build-linux-kernel; then
  phoronix-test-suite install build-linux-kernel
fi
