#h!/bin/bash

if [ "$(id -u)" != "0" ]; then
	echo "Error: Root priviledge is required to run" >&2
	exit 1
fi

CDIR=$(dirname $0)
$HOME/opt/pyenv/versions/3.8.5/bin/python3.8 "$CDIR/xkeysnail/bin/xkeysnail" --quiet config.py

