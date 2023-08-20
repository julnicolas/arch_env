#!/bin/sh

# The delta binary (rust) must be installed
# This script adapts delta's theme to active
# terminal's settings

echo "$SCHEME"
if [ "$SCHEME" == "light" ]; then
	delta --light "$@"
	exit $?
fi

delta "$@"
