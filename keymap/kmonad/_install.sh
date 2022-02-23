#!/bin/bash

set -e

dir=$(cd $(dirname $0); pwd)
ln -sf "$dir" "$XDG_CONFIG_HOME/"

# "$dir/build.sh"
# cp "$dir/kmonad@.service" "$XDG_CONFIG_HOME/systemd/user/"
# systemctl enable --user kmonad@dumang_left kmonad@dumang_right
# systemctl enable --user kmonad@dumang_left
cp "$dir/kmonad.service" "$XDG_CONFIG_HOME/systemd/user/"
systemctl enable --user kmonad

