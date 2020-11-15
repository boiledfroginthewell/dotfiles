# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

if [ -n "$ZSH_VERSION" ]; then
  shell=zsh
else
  shell=bash
fi
# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.$shell" 2> /dev/null

# Key bindings
# ------------
KEY_BINDING_FILE="/usr/local/opt/fzf/shell/key-bindings.$shell"
source <(< $KEY_BINDING_FILE sed 's/.*bindkey .*\^T.*//')

