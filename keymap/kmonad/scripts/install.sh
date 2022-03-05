#!/bin/bash

set -e

dir=$(cd $(dirname $(dirname $0)); pwd)
ln -sf "$dir" "$XDG_CONFIG_HOME/"

# "$dir/build.sh"
# cp "$dir/kmonad@.service" "$XDG_CONFIG_HOME/systemd/user/"
# systemctl enable --user kmonad@dumang_left kmonad@dumang_right
# systemctl enable --user kmonad@dumang_left
cp "$dir/kmonad.service" "$XDG_CONFIG_HOME/systemd/user/"
systemctl enable --user kmonad

sleep 1
if systemctl is-active --user kmonad.service --quiet; then
	systemctl restart --user kmonad.service
fi

