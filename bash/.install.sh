#!/usr/bin/env bash

CDIR=$(cd $(dirname $0); pwd)

if [ "$OSTYPE" = "msys" ]; then
	cmd="mklink"
else
	cmd="ln -s"
fi

$cmd "$CDIR/profile" ~/.profile
$cmd "$CDIR/bashrc" ~/.bashrc
$cmd "$CDIR" "$XDG_CONFIG_HOME/bash"

