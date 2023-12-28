not status -i || status -c && exit
[ (uname) != Darwin ] && exit

# Set PATH, MANPATH, etc., for Homebrew.
eval (/opt/homebrew/bin/brew shellenv)

set -p PATH "$HOME/opt/bin"
set -Ux CONFIG_MODE job
