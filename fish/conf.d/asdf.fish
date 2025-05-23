not status -i || status -c && exit

set -gx ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"
set -gx ASDF_CONFIG_FILE "$XDG_CONFIG_HOME/asdf/asdfrc"


# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims

