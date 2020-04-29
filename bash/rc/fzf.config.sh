export FZF_DEFAULT_OPTS="--reverse --multi --cycle --ansi"

KEY_BINDING_FILE=/usr/share/doc/fzf/examples/key-bindings.bash
if [ -e "$KEY_BINDING_FILE" ]; then
	# Change C-t to C-s
	source <(< $KEY_BINDING_FILE sed 's/\C-t/\C-s/')
fi
FZF_CTRL_T_OPTS='
--bind "ctrl-l:execute(l {} > /dev/tty )"
'

COMPLETION_FILE=/usr/share/bash-completion/completions/fzf
if [ -e "$COMPLETION_FILE" ]; then
	source $COMPLETION_FILE
fi

