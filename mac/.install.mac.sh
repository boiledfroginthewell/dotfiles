#!/bin/sh

CDIR="$(cd $(dirname %0); pwd)"
TARGET_DIR="$HOME/Library/LaunchAgents"

if [ -e "$TARGET_DIR/dotfiles.plist" ]; then
	launchctl unload "$TARGET_DIR/dotfiles.plist"
fi
ln -sf "$CDIR/dotfiles.plist" "$TARGET_DIR"
launchctl load "$TARGET_DIR/dotfiles.plist"

