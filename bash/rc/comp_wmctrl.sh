_comp_wmctrl_printOptions() {
	wmctrl -h | grep -E '^ *-'
}

_comp_wmctrl_getOptions() {
	_comp_wmctrl_printOptions | awk '{print $1}'
}

_comp_wmctrl() {
	case "$3" in 
	wmctrl)
		# get list of all options
		COMPREPLY=( $(compgen -W "$(_comp_wmctrl_getOptions)" -- $2) )
		;;
	#"")
		#;;
	#*)
		#option=$(_comp_wmctrl_printOptions | grep -- $3)
		#echo $option
		#if (_comp_wmctrl_Options
		#;;
	esac
}
complete -F _comp_wmctrl wmctrl
