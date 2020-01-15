CONF_DIR=$HOME/cfg/dotfiles

echo "Configuring XDG_CONFIG_HOME ..."
< "$CONF_DIR/bash/bashrc" sed -i 's/export XDG_CONFIG_HOME=.*$/export XDG_CONFIG_HOME="$HOME/cfg/dotfiles"'

echo "Replacing git user information by ***REMOVED***..."
< "$CONF_DIR/git/config" sed -i -e 's/boiledfroginthewell@users\.noreply\.github\.com/***REMOVED***@***REMOVED***/' -e 's/boiledfroginthewell/***REMOVED***/'

