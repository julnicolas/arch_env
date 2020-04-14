#! /bin/sh

# Be aware your device must be discoverable before starting this script

if [ -z $1 ]; then
	echo "You must provide a MAC address to pair your device"
	exit 1
fi

DEVICE=$1

echo "Scanning..."
bluetoothctl scan on &
echo "Removing device : $DEVICE"
bluetoothctl remove $DEVICE
echo "Sleeping 15 seconds"
sleep 15
echo "Atempting pairing with $DEVICE"
bluetoothctl pair $DEVICE
echo "Connecting to $DEVICE"
bluetoothctl connect $DEVICE
echo "Trusting $DEVICE"
bluetoothctl trust $DEVICE
echo "Disabling scanning"
killall bluetoothctl
echo "Done"
