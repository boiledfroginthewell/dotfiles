#!/bin/sh

PJDIR=$(cd $(dirname $0); git rev-parse --show-toplevel)

if [ ! -L "$XDG_CONFIG_HOME/karabiner" ]; then
	ln -s $PJDIR/karabiner $XDG_CONFIG_HOME/karabiner
	echo Installed karabiner config
else
	echo karabiner is already installed.
fi

# VSCode
VSCODE_CONF_DIR="$HOME/Library/Application Support/Code/User"
if [ -e "$VSCODE_CONF_DIR" ]; then
	rmdir "$VSCODE_CONF_DIR/snippets"
	rm "$VSCODE_CONF_DIR/settings.json"
	ln -s "$PJDIR/vscode/settings.json" "$VSCODE_CONF_DIR/"
	ln -s "$PJDIR/vscode/snippets" "$VSCODE_CONF_DIR/"
	echo Installed VSCode config
else
	echo Skipping VSCode
fi

