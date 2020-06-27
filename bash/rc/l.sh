if [[ "$OSTYPE" != "darwin"* ]]; then
	READLINK_COMMAND="readlink -m"
else
	READLINK_COMMAND="echo"
fi

l() {
local LESS_COMMAND=$(type lv > /dev/null 2>&1 && echo lv || echo less)
local OPEN_COMMAND=$(type exo-open > /dev/null 2>&1 && echo exo-open || \
	(type xdg-open > /dev/null 2>&1 && echo xdg-open ||  \
	echo open))
local LS="${L_LS_COMMAND:-ls --color=auto -p}"

opt=""
while [ "${1:0:1}" = "-" ]; do
	opt=$opt' '"$1"
	shift
done

# execute ls for directory and less for file
if [ ! -t 0 ]; then
	# read data from stdin
	$LESS_COMMAND $opt
elif [ -z "$1" ];then
	$LS $opt $1
elif [ -d "$1" ]; then
	$LS $opt "$1"
elif file --mime "$($READLINK_COMMAND "$1")" | grep -q -e 'charset=binary' ;then
	$OPEN_COMMAND "$1"
else
	$LESS_COMMAND "$1"
fi
}
