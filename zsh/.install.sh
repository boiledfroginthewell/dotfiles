#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

ln -sf "$CDIR/profile" ~/.profile
ln -sf "$CDIR/zshrc" ~/.zshrc
ln -sf "$CDIR" "$XDG_CONFIG_HOME/"

