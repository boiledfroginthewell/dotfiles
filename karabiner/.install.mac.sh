#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

if [ ! -L "$XDG_CONFIG_HOME/karabiner" ]; then
	ln -s "$CDIR" $XDG_CONFIG_HOME/karabiner
	echo Installed karabiner config
else
	echo karabiner is already installed.
fi

