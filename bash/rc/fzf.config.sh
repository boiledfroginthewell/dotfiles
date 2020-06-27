export FZF_DEFAULT_OPTS="--reverse --multi --cycle --ansi"
if type fd &> /dev/null; then
	export FZF_DEFAULT_COMMAND="fd ."
fi

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
	local query="${READLINE_LINE##* }"
	if [[ -d "$query" ]]; then
		PIPE='fd . "$query"'
	elif [[ "$query" = *"/"* && -d "$(dirname $query)" ]]; then
		PIPE='fd "$(basename)" "$(dirname query)"'
	else
		GIT_ROOT="$(git rev-parse --show-toplevel 2>/dev/null)"
		if [ -n "$GIT_ROOT" ]; then
			PIPE="fd . . $GIT_ROOT"
		else
			PIPE='fd .'
		fi
	fi
	local output=$(
		eval \
			$PIPE " | " fzf-tmux \
			--height ${FZF_TMUX_HEIGHT:-40%} \
			--query \'"${query}"\' \
			$FZF_CTRL_T_OPTS
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

