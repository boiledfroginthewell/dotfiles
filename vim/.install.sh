#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

ln -s "$CDIR/vimrc" ~/.vimrc
ln -s "$CDIR/gvimrc" ~/.gvimrc
ln -s "$CDIR" ~/.vim
ln -s "$CDIR" "$XDG_CONFIG_HOME"

