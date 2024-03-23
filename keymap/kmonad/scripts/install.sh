#!/bin/bash
set -eu -o pipefail

dir=$(cd $(dirname $(dirname $0)); pwd)
ln -sf "$dir" "$XDG_CONFIG_HOME/"

if systemctl is-enabled --user kmonad --quiet; then
  systemctl reenable --user "$dir/dist/units/kmonad.service"
else
  systemctl enable --user "$dir/dist/units/kmonad.service"
fi

if systemctl is-active --user kmonad --quiet; then
	echo Restarting Kmonad
	systemctl restart --user kmonad
fi

