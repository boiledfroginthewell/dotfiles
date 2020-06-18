#!/bin/sh

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

