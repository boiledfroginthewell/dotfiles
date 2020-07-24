#!/bin/sh

PJDIR=$(cd $(dirname $0); git rev-parse --show-toplevel)

if [ ! -L "$XDG_CONFIG_HOME/karabiner" ]; then
	ln -s $PJDIR/karabiner $XDG_CONFIG_HOME/karabiner
else
	echo karabiner is already installed.
fi

