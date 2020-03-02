#!/bin/bash

RESULT=$( fd -t d . | cat <(z -l | cut -c 12-) - | fzy -q "$1" )
if [ -n "$RESULT" ]; then
	\cd "$RESULT"
fi

