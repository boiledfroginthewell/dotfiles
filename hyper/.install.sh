#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)
confDir="$XDG_CONFIG_HOME/hyper"
mkdir -p "$confDir"
ln -s $CDIR/hyper.js "$confDir/.hyper.js"

