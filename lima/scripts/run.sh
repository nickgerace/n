#!/usr/bin/env bash
set -euo pipefail

distribution=${1:-nixos}
case "$distribution" in
  nixos|fedora) ;;
  *)
    printf 'usage: %s [nixos|fedora]\n' "${0##*/}" >&2
    exit 2
    ;;
esac

name=$distribution
flake=$(cd "$(dirname "$0")/.." && pwd)/flake.nix
cpus=$(sysctl -n hw.logicalcpu_max)
memory=$(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024))

if limactl list --format '{{.Name}}' | grep -qx "$name"; then
  test "$(limactl list "$name" --format '{{.VMType}}')" = vz
  limactl edit --mount-none --tty=false "$name"
else
  if [ "$distribution" = nixos ]; then
    limactl create --name "$name" --cpus "$cpus" --memory "$memory" --disk 100 --mount-none --vm-type=vz --tty=false github:nixos-lima
  else
    limactl create --name "$name" --cpus "$cpus" --memory "$memory" --disk 100 --mount-none --vm-type=vz --tty=false template:fedora
  fi
fi

if [ "$distribution" = nixos ]; then
  limactl shell --tty=false --start "$name" sh -c 'install -d /tmp/nixos-lima && cat > /tmp/nixos-lima/flake.nix' < "$flake"
  limactl shell --workdir /tmp/nixos-lima "$name" sudo nixos-rebuild switch --flake .#lima
else
  limactl shell --tty=false --start "$name" sudo dnf install -y bash cargo clang curl git helix htop mold rust rust-src wget zsh
fi
