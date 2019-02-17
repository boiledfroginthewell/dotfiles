l() {
local LESS=$(type lv > /dev/null 2>&1 && echo lv || echo less)

if [ $# -eq 0 ]; then
	if [ -t 0 ]; then
		ls
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
	ls $opt $1
elif [ -d "$1" ]; then
	ls $opt "$1"
elif file --mime "$1" | grep 'charset=binary'  > /dev/null ;then
	exo-open "$1"
else
	$LESS "$1"
fi
}
