# My arch linux environment

## How to install
``` sh
cd ~
git clone git@github.com/Juli3nnicolas/arch_env.git
cp -r arch_env/dot_files/.* . 
```

## Repo's content description
- The `script` folder contains various helpers:
	- bluetooth - contains bluetooth-related helpers
		- reconnect.sh - is used to reconnect bluetooth devices (ex - the bridge bluetooth keyboard). After a reboot to windows
		some devices can "get confused" and must be re-paired with linux.
