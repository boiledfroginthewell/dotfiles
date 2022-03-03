#!/bin/bash

# set -e

cdir="$(dirname $0)"

# eval "$(pyenv init -)"
# cd "$cdir"
# pyenv activate

# concat dumang input devices
if ! pgrep -afl cat-dumang.py; then
	"$cdir/cat-dumang.py" &
	sleep 1
fi

# trap "pkill -f cat-dumang.py" HUP INT QUIT TERM EXIT

# find input device file for dumnang's
devFile=""
for x in /sys/devices/virtual/input/input*; do
	name="$(cat "$x/name")"
	if [ "$name" = "dumang-cat" ]; then
		devFile="/dev/input/$(ls "$x" | grep "^event")"
		echo "device file  $x, $devFile"
		break
	fi
done

# start xcape for better SandS
pkill xcape
xcape -t 200 -e '#62=space'

# start kmonad
< "$cdir/dvorak-logicalshift.kbd" sed "s:%INPUT_DEVICE_FILE%:$devFile:" > "$cdir/.rendered.kbd"
kmonad "$cdir/.rendered.kbd"

wait

