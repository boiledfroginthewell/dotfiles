#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

if [ -L "$XDG_CONFIG_HOME/karabiner" ]; then
	echo karabiner is already installed.
	exit 0
elif [ -d "$XDG_CONFIG_HOME/karabiner" ]; then
	echo Backup existing directory
	mv "XDG_CONFIG_HOME/karabiner"{,_}
fi


ln -s "$CDIR" $XDG_CONFIG_HOME/karabiner
echo Installed karabiner config

