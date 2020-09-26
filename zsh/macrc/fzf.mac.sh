# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
KEY_BINDING_FILE="/usr/local/opt/fzf/shell/key-bindings.bash"
# source <(< $KEY_BINDING_FILE sed 's/\C-t/\C-s/')
source <(< $KEY_BINDING_FILE sed 's/.*bind .*C-t.*/:/')

