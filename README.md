# sysinfo

`sysinfo` prints a concise snapshot of a Linux server: load, root filesystem
usage, memory and swap utilisation, process count, active SSH connections,
network addresses, and uptime.

```
 System information as of Sat Oct 17 20:55:36 UTC 2026

  System load:            0.01
  Usage of /:             14% of 16G
  Memory usage:           15%
  Swap usage:             0%
  Processes:              126
  Users logged in:        1
  IPv4 address for eth0:  172.16.0.12
  IPv6 address for eth0:  2602:ffb6:3:bdb1:1a3c:41a6:b055:862d
  Public IPv4 address:    170.75.162.102

The uptime of this server is 9h 49m.
```

By default, `sysinfo` reports addresses assigned directly to network
interfaces. Use `--public-ip` when a provider uses NAT and exposes the public
IPv4 mapping through a cloud metadata service at `169.254.169.254`. The
private address remains visible because it is the address actually assigned
to the network interface.

The presentation is inspired by the familiar `landscape-sysinfo` output, but
this is an independent POSIX shell implementation that is much faster and lightweight.
It does not install or depend on Ubuntu Landscape.

## Mirors

Public Git mirrors of my Mercurial repo:

- [sysinfo on GitLab](https://gitlab.com/uxmaster/sysinfo)
- [sysinfo on GitHub](https://github.com/uxmaster/sysinfo)

## Installation

On [Devuan](https://www.devuan.org/), with the Enabla repository configured:

```sh
sudo apt update
sudo apt install sysinfo
```

Run it directly:

```sh
sysinfo
sysinfo --public-ip
```

It is also suitable for invocation from a login profile or an
`update-motd.d` script when a system administrator wants the summary shown at
login.

## Runtime requirements

The package depends on `iproute2` for the `ip` and `ss` commands and on
`curl` for the optional local cloud metadata query.
Other metrics are read directly from `/proc` using standard base-system
tools; no data is sent anywhere.

## Building on Devuan

Install the packaging tools and build from the repository root:

```sh
sudo apt install build-essential debhelper
dpkg-buildpackage -us -uc -b
```

The resulting architecture-independent package is written to the parent
directory.

## License

Copyright © 2026 [dr Jacek Stypuła](https://jacekstypula.pl/phd).
Licensed under the WTFPL, version 2. See [`LICENSE`](LICENSE).
