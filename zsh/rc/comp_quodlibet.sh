__quodlibetcomp() {
	case "$3" in 
	quodlibet)
		COMPREPLY=( $(compgen -W "$(quodlibet --help|awk '/^  --/{print $1}')" -- $2))
		if [ ${#COMPREPLY[@]} -eq 1 ];then
			compopt -o nospace
			COMPREPLY=( $(echo $COMPREPLY[0] | cut -d "=" -f 1)=)
		fi

		;;
	esac
}
complete -o default -F __quodlibetcomp quodlibet
