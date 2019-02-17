xdotoolcomp() {
	case "$3" in 
	xdotool)
		COMPREPLY=( $(compgen -W "$(xdotool 2>/dev/null| tail -n+2)" $2))
		;;
	esac
}
complete -F xdotoolcomp xdotool
