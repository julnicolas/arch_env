# My arch linux environment

## How to install
``` sh
cd ~
git clone git@github.com/julnicolas/arch_env.git
cp -r arch_env/dot_files/.* . 
```

## Repo's content description
- The `script` folder contains various helpers:
	- bluetooth - contains bluetooth-related helpers
		- reconnect.sh - is used to reconnect bluetooth devices (ex - the bridge bluetooth keyboard). After a reboot to windows
		some devices can "get confused" and must be re-paired with linux.
- `dot_files` contains `.` files to be copied in the corresponding directories
in your home
- `etc` contains configuration files to be copied in `/etc`

## Installation guides
### SDDM (Simple Desktop Display Manager)
This is the login prompt, in july 2023 the following packages must be installed
to make it work:
``` sh
qt5-base
qt5-declarative
qt5-svg
qt5-translations
qt5-wayland
qt5ct
layer-shell-qt
sddm
archlinux-themes-sddm
```
