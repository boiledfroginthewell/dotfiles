#!/bin/bash

CDIR=$(dirname $(readlink -f $0))
/home/mh/opt/pyenv/versions/3.8.5/bin/python3.8 "$CDIR/xkeysnail/bin/xkeysnail" --quiet "$CDIR/config.py"

