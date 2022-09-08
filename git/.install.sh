#!/bin/sh

# throws error on undefined variables
set -u


if [ -n "$XDG_CONFIG_HOME" ]; then
	echo "Error: XDG_CONFIG_HOME is not defined. Set XDG_CONFIG_HOME explicitly since git does not use XDG Directories when they are blank. The default value of XDG_CONFIG_HOME is ~/.config" >&2
	exit 1
fi

echo Enter Git default user name:
read GIT_USER_NAME
echo Enter Git default email:
read GIT_EMAIL
echo ""

PRJ_ROOT="$(cd $(dirname "$0"); git rev-parse --show-toplevel)"

echo Creating $PRJ_ROOT/git/userconfig with the following content:
echo "[user]
	name = $GIT_USER_NAME
	email = $GIT_EMAIL
" | tee "$PRJ_ROOT/git/userconfig"

