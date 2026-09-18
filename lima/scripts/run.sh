#!/usr/bin/env bash
set -euo pipefail

name=nixos
flake=$(cd "$(dirname "$0")/.." && pwd)/flake.nix
cpus=$(sysctl -n hw.logicalcpu_max)
memory=$(($(sysctl -n hw.memsize) / 1024 / 1024 / 1024))

if limactl list --format '{{.Name}}' | grep -qx "$name"; then
  test "$(limactl list "$name" --format '{{.VMType}}')" = vz
  limactl edit --mount-none --tty=false "$name"
else
  limactl create --name "$name" --cpus "$cpus" --memory "$memory" --disk 200 --mount-none --vm-type=vz --tty=false github:nixos-lima
fi

limactl shell --tty=false --start "$name" sh -c 'install -d /tmp/nixos-lima && cat > /tmp/nixos-lima/flake.nix' < "$flake"
limactl shell --workdir /tmp/nixos-lima "$name" sudo nixos-rebuild switch --flake .#lima
