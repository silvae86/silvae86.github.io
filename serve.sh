#!/usr/bin/env bash

if [[ "$OSTYPE" == "darwin"* ]]; then
	source "./scripts/serve_mac.sh"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	source "./scripts/serve_linux.sh"
fi