not status -i || status -c && exit

if not set -q ASDF_DIF && test -e "$HOME/.asdf"
	set -gx ASDF_DIR "$HOME/.asdf"
end
set -gx ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"
set -gx ASDF_CONFIG_FILE "$XDG_CONFIG_HOME/asdf/asdfrc"

if type -q brew
	source (brew --prefix asdf)/libexec/asdf.fish
else
	source "$ASDF_DIR"/asdf.fish
	set -p fish_complete_path "$ASDF_DIR/completions"
end

