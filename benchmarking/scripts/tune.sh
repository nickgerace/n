#!/usr/bin/env bash
set -eu

if [[ "$DESKTOP_SESSION" = "gnome" ]]; then
  echo "set power profile to 'Performance'"
else
  echo "execute the following:"
  echo ""
  echo "  echo governor | tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor"
  echo ""
  echo "reference: https://openbenchmarking.org/result/1706268-TR-CPUGOVERN32"
fi
