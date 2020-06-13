# Activate autoenv
if [ -e "${HOME}/opt/autoenv/activate.sh" ]; then
	export AUTOENV_AUTH_FILE="${XDG_CONFIG_HOME}/autoenv/autoenv_authorized"
	source "${HOME}/opt/autoenv/activate.sh"
	AUTOENV_INIT=autoenv_init
fi

# ls after cd
cl () {
	\cd "$@" && ls
	$AUTOENV_INIt
}
alias cd=cl

zl() {
	z "$@" && ls
}

alias z=zl

# Install fasd
type fasd &> /dev/null && eval "$(fasd --init auto)"

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


alias zc='z "$(pwd)" "$@"'

