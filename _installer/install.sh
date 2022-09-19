#!/bin/bash

set -u

help() {
	echo "$0 -e [pattern]"
	exit
}

highlight() {
	tput bold
	tput setaf 5
	echo "$*"
	tput sgr0
}

READLINK=readlink
type greadlink &> /dev/null && READLINK=greadlink

if ! type fd &>/dev/null; then
	echo Error: fd is not found. Install fd first.
	exit 1
fi


NO_DRY_MODE="echo dry run: "
while getopts 'eh' ARG; do
	case $ARG in
	e)
		NO_DRY_MODE=
		;;
	h|\?)
		help
		;;
	esac
done

shift $(( OPTIND - 1 ))

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


for x in $(fd "\.xdg_config_home(\.$OS)?" --maxdepth 2 -H | sed 's:^\./::'); do
	confname=$(dirname "$x")
	if [[ ! $x =~ .*$*.* ]]; then
		continue
	fi

	dest="$XDG_CONFIG_HOME/$confname"
	if [[ $($READLINK -f "$dest") = "$CONF_DIR/$confname" ]]; then
		status="installed"
	else
		status="not installed"
	fi
	highlight "### XDG_CONFIG found: $confname ($status)"
	if [[ "$status" = "installed" ]]; then
		echo Skipping installation
		continue
	fi
	if [ -f "$dest" ]; then
		echo Warn: Overwriting file: $confname >&2
	elif [ -d "$dest" ]; then
		echo Warn: Overwriting directory: $confname >&2
		$NO_DRY_MODE rm -rf "$dest"
	fi
	$NO_DRY_MODE ln -sf "$CONF_DIR/$confname" "$dest"
done
echo ""


highlight "## Installing custom settings..."
for x in $(fd "\.install(\.$OS)?\.sh" --maxdepth 2 -H); do
	confname=$(dirname "$x")
	if [[ ! $x =~ .*$*.* ]]; then
		continue
	fi

	highlight "### Custom Installer found: $confname"
	$NO_DRY_MODE $x
done

