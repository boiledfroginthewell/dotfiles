#!/bin/bash

set -eu

cdir="$(dirname $0)"
# eval "$(pyenv init -)"
# source "$ASDF_DIR/asdf.sh"
cd "$cdir"
source .venv/bin/activate
# pyenv activate

# concat dumang input devices
if ! pgrep -afl cat-dumang.py; then
	# 05...57229 is the left and 05...48234 is the right
	"$cdir/cat-dumang.py" \
		"/dev/input/by-id/usb-www.BeyondQ.com_DuMang_KeyBoard_DK6_05D6FF313431474843257220-event-kbd" \
		"/dev/input/by-id/usb-www.BeyondQ.com_DuMang_KeyBoard_DK6_05D8FF303037484843148234-event-kbd" \
		&
	sleep 1
fi

 trap "pkill -f cat-dumang.py" HUP INT QUIT TERM EXIT

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
# devFile=/dev/input/by-path/platform-i8042-serio-0-event-kbd
# if [ -z "$devFile" ]; then
# 	echo No device file was found >&2
# 	exit 1
# fi

# # start xcape for better SandS
# pkill xcape || :
# sleep 2
# xcape -t 200 -e '#62=space'
# echo xcape result: $?

# start kmonad
#kbdName=dvorak-logicalshift.kbd
kbdName=40keys.kbd
< "$cdir/$kbdName" sed "s:%INPUT_DEVICE_FILE%:$devFile:" > "$cdir/.rendered.$kbdName.kbd"
kmonad "$cdir/.rendered.$kbdName.kbd"

wait

