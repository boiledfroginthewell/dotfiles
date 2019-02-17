__pomolog=$HOME/.pomolog
__pomcomp() {
	case "$3" in 
	pomodoro)
		if [ -e $__pomolog ]; then
			COMPREPLY=( $(compgen -W "$(cut -f 3 $__pomolog| sort | uniq)" $2))
		fi
		;;
	esac
}
complete -F __pomcomp pomodoro
