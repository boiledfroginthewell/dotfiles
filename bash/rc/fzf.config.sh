export FZF_DEFAULT_OPTS="--reverse --multi --cycle --ansi --bind "ctrl-a:toggle-all""
export FZF_DEFAULT_COMMAND=fzf-default-command

KEY_BINDING_FILE=/usr/share/doc/fzf/examples/key-bindings.bash
if [ -e "$KEY_BINDING_FILE" ]; then
	# Change C-t to C-s
	# source <(< $KEY_BINDING_FILE sed 's/\C-t/\C-s/')
	# Disable C-t Mapping
	source <(< $KEY_BINDING_FILE sed 's/.*bind .*C-t.*/:/')
fi
FZF_CTRL_T_OPTS='--bind "ctrl-l:execute(l {} > /dev/tty )"'

COMPLETION_FILE=/usr/share/bash-completion/completions/fzf
if [ -e "$COMPLETION_FILE" ]; then
	source $COMPLETION_FILE
fi

_fzf_config_insert() {
	local input_value="${READLINE_LINE##* }"
	if [[ -d "$input_value" ]]; then
		query=
		directory="$input_value"
	elif [[ "$input_value" = *"/"* && -d "$(dirname $input_value)" ]]; then
		command="fd ."
		query="$(basename $input_value)"
		directory="$(dirname $input_value)"
	else
		query="$input_value"
		directory=
	fi

	local output=$(
		eval \
			"${command:-fzf-default-command} \"$directory\" | \
			fzf-tmux \
			--height ${FZF_TMUX_HEIGHT:-40%} \
			--query \"${query}\" \
			$FZF_CTRL_T_OPTS"
	)
	if [ -z "${output}" ]; then
		return
	fi

	if [ -z "$query" ]; then
		READLINE_LINE="${READLINE_LINE} "
	else
		READLINE_LINE="${READLINE_LINE%${query}}"
	fi
	READLINE_LINE="${READLINE_LINE}${output#*$'\t'}"
	if [ -z "$READLINE_POINT" ]; then
		echo "$READLINE_LINE"
	else
		READLINE_POINT=0x7fffffff
	fi
}
# Customization
bind -x '"\C-s": _fzf_config_insert'

