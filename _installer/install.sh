#!/bin/bash

set -u

READLINK=readlink
type greadlink &> /dev/null && READLINK=greadlink

help() {
	echo "$0 [-t install_pattern] [install]"
	exit
}

target=""
while getopts 't:h' ARG; do
	case $ARG in
	t)
		target="$OPTARG"
		;;
	h|\?)
		help
		;;
	esac
done

shift $(( OPTIND - 1 ))
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

echo "## Copying XDG directories based settings..."
for x in $(fd "\.xdg_config_home(\.$OS)?" --maxdepth 2 -H); do
	confname=$(dirname "$x")
	if [[ $confname != *"$target"* ]]; then
		continue
	fi

	dest="$XDG_CONFIG_HOME/$confname"
	status="not installed"
	if [[ $($READLINK -f "$dest") = "$CONF_DIR/$confname" ]]; then
		status="installed"
	fi
	echo "### XDG_CONFIG found: $confname ($status)"
	if [[ "$status" = "installed" ]]; then
		continue
	fi
	if [ -f "$dest" ]; then
		echo Warn: Overwriting $confname >&2
	fi
	$NO_DRY_MODE ln -sf "$CONF_DIR/$confname" "$dest"
done
echo ""


echo "## Installing custom settings..."
for x in $(fd "\.install(\.$OS)?\.sh" --maxdepth 2 -H); do
	confname=$(dirname "$x")
	if [[ $confname != *"$target"* ]]; then
		continue
	fi

	echo "### Custom Installer found: $confname"
	$NO_DRY_MODE $x
done

