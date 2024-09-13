not status -i || status -c && exit

set -gx __JUMPER_FOLDERS $XDG_DATA_HOME/jumper/jfolders
set -gx __JUMPER_FILES $XDG_DATA_HOME/jumper/jfiles

jumper shell fish | sed 's;bind \\\\cu;# ;' | source

