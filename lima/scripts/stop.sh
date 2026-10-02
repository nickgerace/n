#!/usr/bin/env bash
set -euo pipefail

name=${1:-nixos}
case "$name" in
  nixos|fedora) ;;
  *)
    printf 'usage: %s [nixos|fedora]\n' "${0##*/}" >&2
    exit 2
    ;;
esac

exec limactl stop "$name"
