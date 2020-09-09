#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

ln -s "$CDIR/bashrc" ~/.bashrc
ln -s "$CDIR" "$XDG_CONFIG_HOME/"

