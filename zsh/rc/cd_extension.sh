# Reset overriding of cd by autoenv
unset cd
# Auto ls
__AUTO_LS_PREV_PWD="$PWD"
__auto_ls() {
	if [ "$__AUTO_LS_PREV_PWD" != "$PWD" ]; then
		__AUTO_LS_PREV_PWD="$PWD"

		# # load nvm
		# _zsh_nvm_auto_use &> /dev/null
		ls
		autoenv_init
	fi
}
add-zsh-hook precmd __auto_ls


# cd toward parent directories
zp() {
	IFS_BK="$IFS"
	IFS=/
	dirs=( $(pwd | sed 's:^/::') )
	IFS="$IFS_BK"

	dest=""
	for x in "${dirs[@]}"; do
		dest="${dest}/$x"
		if [[ "$x" == *"$1"* ]]; then
			shift
		fi

		if [ $# = 0 ];then
			break
		fi
	done

	if [ $# != 0 ];then
		return
	fi

	cd "$dest"
}

# "cd ../" multiple times
__z_multi_dots() {
	if [ $# = 0 ];then
		return
	fi

	echo $1
	pat="^[0-9]+$"
	if [[ ! $1 =~ $pat ]]; then
		return
	fi

	cd $(printf "../%.0s" $(seq $1))
}
alias z.=__z_multi_dots


alias zc='z -c "$@"'

