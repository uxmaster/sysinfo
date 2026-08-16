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
if printf '%s\n' "$output" | grep -q 'Public IPv4 address:'; then
	echo 'default output unexpectedly queried the public IPv4 address' >&2
	exit 1
fi

$base/sysinfo --help | grep -q '^usage: sysinfo '
if $base/sysinfo --unknown >/dev/null 2>&1; then
	echo 'unknown option unexpectedly succeeded' >&2
	exit 1
fi

SYSINFO_TEST_SOURCE_ONLY=1 . "$base/sysinfo"

ip() {
	printf '%s\n' '169.254.169.254 via 172.16.0.1 dev eth0'
}

curl() {
	printf '%s\n' '170.75.171.97'
}

[ "$(public_ipv4)" = '170.75.171.97' ]

curl() {
	printf '%s\n' 'not-an-address'
}

[ -z "$(public_ipv4)" ]

curl() {
	printf '%s\n' '170.75.171.97' '127.0.0.1'
}

[ -z "$(public_ipv4)" ]

echo 'sysinfo smoke test passed.'
