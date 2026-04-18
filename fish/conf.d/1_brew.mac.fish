not status -i || status -c && exit
[ (uname) != Darwin ] && exit

# Set PATH, MANPATH, etc., for Homebrew.
eval (/opt/homebrew/bin/brew shellenv)

set -x HOMEBREW_NO_AUTO_UPDATE 1
