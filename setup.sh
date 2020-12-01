#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
	source "./scripts/setup_stuff_mac.sh"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	source "./scripts/setup_stuff_linux.sh"
fi