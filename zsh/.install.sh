#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

if [ ! -e "$XDG_CACHE_HOME/autoenv" ]; then
	mkdir -v "$XDG_CACHE_HOME/autoenv"
fi

ln -sf "$CDIR/zshenv" ~/.zshenv
ln -sf "$CDIR/profile" ~/.profile
ln -sf "$CDIR/zshrc" "$CDIR/.zshrc"

./compile.zsh

