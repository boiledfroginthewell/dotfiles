export FZF_DEFAULT_OPTS="--reverse --multi --cycle --ansi"

KEY_BINDING_FILE=/usr/share/doc/fzf/examples/key-bindings.bash
if [ -e "$KEY_BINDING_FILE" ]; then
	source $KEY_BINDING_FILE
fi

COMPLETION_FILE=/usr/share/bash-completion/completions/fzf
if [ -e "$COMPLETION_FILE" ]; then
	source $COMPLETION_FILE
fi


