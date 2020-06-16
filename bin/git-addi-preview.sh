SHOW_DIR_CMD=$(type tree &> /dev/null && echo tree || echo ls)

fileName="${1:3}"
if [[ "$1" = "?? "* ]]; then
	if [ -d "$fileName" ]; then
		$SHOW_DIR_CMD "$fileName"
	else
		cat "$fileName"
	fi
else
	git diff -- "$fileName" | delta $DELTA_DEFAULT_OPTION
fi

