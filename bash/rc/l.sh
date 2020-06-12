l() {
local LESS=$(type lv > /dev/null 2>&1 && echo lv || echo less)
local OPEN=$(type exo-open > /dev/null 2>&1 && echo exo-open || \
	(type xdg-open > /dev/null 2>&1 && echo xdg-open ||  \
	echo open))
local LS="ls -F"

if [ $# -eq 0 ]; then
	if [ -t 0 ]; then
		$LS
	else
		# read data from stdin
		lv
	fi
	return
fi

opt=""
while [ "${1:0:1}" = "-" ]; do
	opt=$opt' '"$1"
	shift
done

# execute ls for directory and less for file
if [ -z "$1" ];then
	$LS $opt $1
elif [ -d "$1" ]; then
	$LS $opt "$1"
elif file --mime "$(readlink -m  "$1")" | grep 'charset=binary'  > /dev/null ;then
	$OPEN "$1"
else
	$LESS "$1"
fi
}
