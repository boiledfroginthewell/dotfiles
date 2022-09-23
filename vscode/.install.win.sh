#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

# VSCode
VSCODE_CONF_DIR="$HOME/AppData/Roaming/Code/User"
if [ -e "$VSCODE_CONF_DIR" ]; then
	rmdir "$VSCODE_CONF_DIR/snippets"
	rm "$VSCODE_CONF_DIR/settings.json"
	powershell -command "New-Item -Type SymbolicLink -Value \"$CDIR/settings.json\" \"$VSCODE_CONF_DIR/\""
	cmd //C "mklink \"$CDIR/snippets\" \"$VSCODE_CONF_DIR/\""
	powershell -command "New-Item -Type SymbolicLink -Value \"$CDIR/keybindings.json\" \"$VSCODE_CONF_DIR/\""
	echo Installed VSCode config
else
	echo Skipping VSCode
fi

