# sysinfo

`sysinfo` prints a concise snapshot of a Linux server: load, root filesystem
usage, memory and swap utilisation, process count, active SSH connections,
network addresses, and uptime.

The presentation is inspired by the familiar `landscape-sysinfo` output, but
this is an independent POSIX shell implementation. It does not install or
depend on Ubuntu Landscape.

## Installation

On a machine configured to use the Enabla Devuan repository:

```sh
sudo apt update
sudo apt install sysinfo
```

Run it directly:

```sh
sysinfo
```

It is also suitable for invocation from a login profile or an
`update-motd.d` script when a system administrator wants the summary shown at
login.

## Runtime requirements

The Debian package depends on `iproute2` for the `ip` and `ss` commands.
Other metrics are read directly from `/proc` using standard base-system
tools; no data is sent anywhere.

## Building the Debian package

Install the Debian packaging tools and build from the repository root:

```sh
sudo apt install build-essential debhelper
dpkg-buildpackage -us -uc -b
```

The resulting architecture-independent package is written to the parent
directory.

## License

Copyright © 2026 Jacek Stypuła. Licensed under the WTFPL, version 2. See
[`LICENSE`](LICENSE).
