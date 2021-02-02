#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Error: Root priviledge is required to run" >&2
	exit 1
fi

CDIR=$(dirname $(readlink -f $0))

pkill xcape
trap "$CDIR/../xmodmap/xcape.sh; exit" INT QUIT TERM EXIT

/home/mh/opt/pyenv/versions/3.8.5/bin/python3.8 "$CDIR/xkeysnail/bin/xkeysnail" --quiet "$CDIR/config.py"

