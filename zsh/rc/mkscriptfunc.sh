export HISTIGNORE=${HISTIGNORE}':mkscript *'

function mkscript {

if [ $# -eq 0 -o $# -gt 2 ]; then
	cat <<EOS
Convert commands executed so far to a bash script.
Usage:
	mkscript [-i] num

num: Number of commands to be converted.
-i: If this option is enabled, num refer to the index of the history command output.
EOS
	return
fi

echo '#!/bin/bash'
if [ "$1" = "-i" ]; then
	history | awk "{if (\$1 >= $2) print}" | sed 's/ *[0-9]\+ *//' | head -n -1 
else
	history | tail -n $(($1 + 1)) | head -n -1 | sed 's/ *[0-9]\+ *//'
fi

}
