#!/bin/sh
set -eu

base=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
sh -n "$base/sysinfo"
output=$($base/sysinfo)

printf '%s\n' "$output" | grep -q 'System information as of'
printf '%s\n' "$output" | grep -q 'System load:'
printf '%s\n' "$output" | grep -q 'Memory usage:'
printf '%s\n' "$output" | grep -q 'Swap usage:'
printf '%s\n' "$output" | grep -q 'The uptime of this server is'

echo 'sysinfo smoke test passed.'
