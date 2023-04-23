#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

ln -sf "$CDIR" "$XDG_CONFIG_HOME/nvim/lua/user"

