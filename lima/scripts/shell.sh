#!/usr/bin/env bash
set -euo pipefail

name=nixos

exec limactl shell --start "$name"
