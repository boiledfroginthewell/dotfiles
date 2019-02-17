cmd="$HOME/sounds/plmanager"

_plmcomp() {
	case "$3" in
	./plmanager)
		compopt +o default
		COMPREPLY=($(compgen -W "showlist $($cmd showlist)" $2))
		;;
	add)
		compopt -o default
		COMPREPLY=()
		;;
	*)
		# completion of the sub-command
		if [ "$($cmd showlist | grep $3)" = "$3" ]; then
			COMPREPLY=($(compgen -W "add remove show all clear" $2))
		fi
		;;
	esac
}

complete -o default -F _plmcomp plmanager
