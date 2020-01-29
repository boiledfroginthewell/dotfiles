CONF_DIR=$HOME/config/dotfiles

echo "Replacing git user information by ***REMOVED***..."
< "$CONF_DIR/git/config" sed -i -e 's/boiledfroginthewell@users\.noreply\.github\.com/***REMOVED***@***REMOVED***/' -e 's/boiledfroginthewell/***REMOVED***/'

# CMD
mklink /J "$HOME/.vim" "$CONF_DIR/vim"

# git
git config --global --add user.name ***REMOVED***
git config --global --add user.email ***REMOVED***@***REMOVED***
git config --global --add core.pager less

