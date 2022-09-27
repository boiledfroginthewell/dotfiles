#!/bin/bash

_comp_backup() {
	local IFSORG=$IFS
	IFS=$'\n'
	COMPREPLY=($(compgen -W "$(sh ~/bin/showbackup.sh --no-date | tr -d '/' )" $2))
	IFS=$IFSORG
}

complete -o filenames -F _comp_backup recover
