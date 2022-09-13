#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

mklink "$CDIR/vimrc" ~/.vimrc
mklink "$CDIR/gvimrc" ~/.gvimrc
mklink "$CDIR" ~/.vim
# mklink "$CDIR" "$XDG_CONFIG_HOME/vim"

