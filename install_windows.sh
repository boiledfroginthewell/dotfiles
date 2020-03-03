CONF_DIR=$(dirname $0)

# CMD
mklink //J "$HOME/.vim" "$CONF_DIR/vim"

# git
git config --global --add user.name ***REMOVED***
git config --global --add user.email ***REMOVED***@***REMOVED***
git config --global --add core.pager less

