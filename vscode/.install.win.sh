#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

# VSCode
VSCODE_CONF_DIR="$HOME/Library/Application Support/Code/User"
if [ -e "$VSCODE_CONF_DIR" ]; then
	rmdir "$VSCODE_CONF_DIR/snippets"
	rm "$VSCODE_CONF_DIR/settings.json"
	New-Item -Type SymbolicLink "$CDIR/settings.json" "$VSCODE_CONF_DIR/"
	mklink "$CDIR/snippets" "$VSCODE_CONF_DIR/"
	New-Item -Type SymbolicLink "$CDIR/keybindings.json" "$VSCODE_CONF_DIR/"
	echo Installed VSCode config
else
	echo Skipping VSCode
fi

