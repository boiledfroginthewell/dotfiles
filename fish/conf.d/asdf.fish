not status -i || status -c && exit

set -q ASDF_DIR || set -gx ASDF_DIR "$HOME/.asdf"
set -gx ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"
source "$ASDF_DIR"/asdf.fish
set -p fish_complete_path "$ASDF_DIR/completions"

