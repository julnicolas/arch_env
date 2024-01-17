# Steps To Configure Machine
This document contains the steps to configure a new arch-machine.

## Network
### DNS Configuration
Once network is functional, check that `systemd-resolved.service`
is enabled and running.

If so, make a symlink to its `resolv.conf` file so that it can keep
system's version up to date.

``` sh
cd /etc
mv resolv.conf resolv.conf.bu
ln -s /run/systemd/resolve/resolv.conf
```

