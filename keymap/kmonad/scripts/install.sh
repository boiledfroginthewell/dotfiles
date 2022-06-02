#!/bin/bash

set -e

dir=$(cd $(dirname $(dirname $0)); pwd)
ln -sf "$dir" "$XDG_CONFIG_HOME/"

systemctl reenable --user "$dir/kmonad.service"

if systemctl is-active --user kmonad --quiet; then
	echo Restarting Kmonad
	systemctl restart --user kmonad
fi

