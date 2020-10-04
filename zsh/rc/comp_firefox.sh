FIREFOX_INI=~/.mozilla/firefox/profiles.ini
_PROFILE_PATH=~/.mozilla/firefox

_comp_firefox() {
	case "$3" in
	# option completion
	firefox)
		;&
	iceweasel)
		COMPREPLY=($(compgen -W "$(firefox --help 2> /dev/null | grep -Eoe '--?[^ ]+')" -- "$2" ))
		;;
	
	# profile completion
	-P)
		COMPREPLY=($(compgen -W "$(< $FIREFOX_INI grep 'Name=' | cut -d '=' -f 2)" -- "$2" ))
		;;
	--profile)
		COMPREPLY=($(compgen -W "$(< $FIREFOX_INI grep 'Name=' | cut -d '=' -f 2)" -- "$2" ))
		if [ ${#COMPREPLY[@]} -eq 1 ]; then
			COMPREPLY=($(echo $_PROFILE_PATH/*.$COMPREPLY))
		fi
		;;
	esac
}

complete -o default -F _comp_firefox firefox
complete -o default -F _comp_firefox firefox-esr
