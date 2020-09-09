CONF_DIR="$(cd $(dirname $0); git rev-parse --show-toplevel)"

mklink //J "$HOME/.vim" "$CONF_DIR/vim"

source "$CONF_DIR/install_script/common.sh"

