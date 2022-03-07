#!/usr/bin/env bash

source "$HOME/.rvm/scripts/rvm"
source "$HOME/.bashrc"

if [[ "$OSTYPE" == "darwin"* ]]; then
	source "./scripts/serve_mac.sh"
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
	source "./scripts/serve_linux.sh"
fi
