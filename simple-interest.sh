#!/bin/bash
# simple-interest.sh
# Usage: ./simple-interest.sh <principal> <time_years> <rate_percent>
# Outputs the simple interest value.

if [ "$#" -ne 3 ]; then
  echo "Usage: $0 <principal> <time_years> <rate_percent>"
  exit 1
fi

p=$1
t=$2
r=$3

# Validate numeric input (integers or decimals, non-negative)
re='^[0-9]+([.][0-9]+)?$'
if ! [[ $p =~ $re ]] || ! [[ $t =~ $re ]] || ! [[ $r =~ $re ]]; then
  echo "Error: principal, time and rate must be non-negative numbers"
  exit 1
fi

# Calculate simple interest using awk for floating-point arithmetic
si=$(awk -v P="$p" -v T="$t" -v R="$r" 'BEGIN { printf "%.6f", (P * T * R) / 100 }')

# Clean trailing zeros (e.g., 100.000000 -> 100)
si_clean=$(awk -v val="$si" 'BEGIN { sub(/\.0+$/, "", val); sub(/(\.[0-9]*?)0+$/, "\\1", val); print val }')

echo "$si_clean"
