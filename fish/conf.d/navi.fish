not status -i || status -c && exit

set -l confDir "$XDG_CONFIG_HOME/navi"
set -xg NAVI_PATH "$confDir/cheats:$confDir/cheats_$(uname -s | string lower)"

navi widget fish \
| sed 's;\\\\cg;\\\\cp;' \
| source

