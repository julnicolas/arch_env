#! /bin/sh

# Be aware your device must be discoverable before starting this script

BRYDGE_KEYBOARD='DC:2C:26:CB:CE:83'

~/.scripts/bluetooth/reconnect_device.sh $BRYDGE_KEYBOARD &

# This command must be called last so that pin-codes can be entered
bluetoothctl
