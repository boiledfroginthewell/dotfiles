if [[ "$OSTYPE" != "darwin"* ]] || readlink -m . &> /dev/null; then
	# Gnu readlink (coreutils) is available
	READLINK_COMMAND="readlink -m"
else
	# Only BSD readlink is installed
	READLINK_COMMAND="echo"
fi

l() {
	local opt=()
	while [ "${1:0:1}" = "-" ]; do
		opt+=($1)
		shift
	done

	# execute ls for directory and less for file
	if [ ! -t 0 ]; then
		# read data from stdin
		eval ${LESS_COMMAND:-less} "${opt[@]}"
	elif [ -z "$1" ];then
		eval ${LS_COMMAND:-ls} "${opt[@]}"
	elif [ -d "$1" ]; then
		eval ${LS_COMMAND:-ls} "${opt[@]}" "$1"
	elif [ -n "$(file --mime "$(eval $READLINK_COMMAND "$1")" | grep -e 'charset=binary' | grep -v x-empty)" ]; then
		eval ${OPEN_COMMAND:-open} "${opt[@]}" "$1"
	else
		eval ${LESS_COMMAND:-less} "${opt[@]}" "$1"
	fi
}
