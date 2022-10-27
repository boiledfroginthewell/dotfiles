#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

checkpath() {
	VSCODE_CONF_DIR="$XDG_CONFIG_HOME/Code/User"
	[ -e "$VSCODE_CONF_DIR" ] && return

	VSCODE_CONF_DIR="$HOME/Library/Application Support/Code/User"
	[ -e "$VSCODE_CONF_DIR" ] && return

	VSCODE_CONF_DIR="$HOME/Library/Application Support/VSCodium/User"
	[ -e "$VSCODE_CONF_DIR" ] && return
}

checkpath
echo $VSCODE_CONF_DIR

if [ -e "$VSCODE_CONF_DIR" ]; then
	rmdir "$VSCODE_CONF_DIR/snippets"
	rm "$VSCODE_CONF_DIR/settings.json"
	ln -s "$CDIR/settings.json" "$VSCODE_CONF_DIR/"
	ln -s "$CDIR/snippets" "$VSCODE_CONF_DIR/"
	ln -sf "$CDIR/keybindings.json" "$VSCODE_CONF_DIR/"
	ln -s "$CDIR/cheatsheats" "$HOME/.cheatsheets"
	echo Installed VSCode config
else
	echo Skipping VSCode
fi

