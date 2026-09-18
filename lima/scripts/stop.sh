#!/usr/bin/env bash
set -euo pipefail

name=nixos

exec limactl stop "$name"
