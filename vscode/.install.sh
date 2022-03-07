#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

# VSCode
if [[ "$OSTYPE" == "darwin"* ]]; then
	VSCODE_CONF_DIR="$HOME/Library/Application Support/Code/User"
else
	VSCODE_CONF_DIR="$XDG_CONFIG_HOME/Code/User"
fi

if [ -e "$VSCODE_CONF_DIR" ]; then
	rmdir "$VSCODE_CONF_DIR/snippets"
	rm "$VSCODE_CONF_DIR/settings.json"
	ln -s "$CDIR/settings.json" "$VSCODE_CONF_DIR/"
	ln -s "$CDIR/snippets" "$VSCODE_CONF_DIR/"
	ln -sf "$CDIR/keybindings.json" "$VSCODE_CONF_DIR/"
	echo Installed VSCode config
else
	echo Skipping VSCode
fi

