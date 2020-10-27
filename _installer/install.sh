#!/usr/bin/env bash

set -u

NO_DRY_MODE="echo dry run: "
if [ "${1:-}" = "install" ]; then
	NO_DRY_MODE=
fi

CONF_DIR=$(git rev-parse --show-toplevel)
cd "$CONF_DIR"

if [ -z "${XDG_CONFIG_HOME}" ]; then
	echo "Error: XDG_CONFIG_HOME is undefined." >&2
	exit 1
fi

if [ $(uname -s) = Darwin ]; then
	export OS=mac
else
	export OS=linux
fi

echo Copying XDG directories based settings...
for x in $(fd "\.xdg_config_home(\.$OS)?" --maxdepth 2 -H); do
	confname=$(dirname "$x")

	echo "XDG_CONFIG found: $confname"
	dest="$XDG_CONFIG_HOME/$confname"
	if [ -f "$dest" ]; then
		echo Warn: Overwriting $confname >&2
	fi
	$NO_DRY_MODE ln -sf "$CONF_DIR/$confname" "$dest"
done
echo ""


echo Installing custom settings...
for x in $(fd "\.install(\.$OS)?\.sh" --maxdepth 2 -H); do
	confname=$(dirname "$x")

	echo "Custom Installer found: $confname"
	$NO_DRY_MODE $x
done

