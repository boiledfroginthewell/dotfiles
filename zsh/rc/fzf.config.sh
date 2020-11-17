export FZF_DEFAULT_OPTS="--reverse --multi --cycle --ansi --bind "ctrl-a:toggle-all""
export FZF_DEFAULT_COMMAND=fzf-default-command

KEY_BINDING_FILE=/usr/share/doc/fzf/examples/key-bindings.$(basename $SHELL)
if [ -e "$KEY_BINDING_FILE" ]; then
	# Change C-t to C-s
	# source <(< $KEY_BINDING_FILE sed 's/\C-t/\C-s/')
	# Disable C-t Mapping
	source <(< $KEY_BINDING_FILE sed 's/.*bindkey .*\^T.*/:/')
fi
FZF_CTRL_T_OPTS='--bind "ctrl-l:execute(l {} > /dev/tty )"'

# COMPLETION_FILE=/usr/share/bash-completion/completions/fzf
# if [ -e "$COMPLETION_FILE" ]; then
# 	source $COMPLETION_FILE
# fi


_fzf_config_insert_git() {
	case "$(<<<"$LBUFFER" cut -d ' ' -f 2)" in
		stash|add|restore)
			git status --short | \
			fzf \
				--height ${FZF_HEIGHT:-40%} \
				--preview "git diff --color=always -- \$(<<<{} cut -c 4-) | delta $DELTA_DEFAULT_OPTION" | \
			cut -c 4-
			return
			;;
		*)
			echo __fallback
			return
			;;
	esac
}

_fzf_config_insert() {
	local query directory command
	local input_value="${LBUFFER##* }"
	input_value="${input_value/#\~/$HOME}"
	if [[ -d "${input_value}" ]]; then
		command="fd ."
		query=
		directory="${input_value}"
	elif [[ "$input_value" = *"/"* && -d "$(dirname $input_value)" ]]; then
		command="fd ."
		query="$(basename $input_value)"
		directory="$(dirname $input_value)"
	elif [[ "$LBUFFER" = "git"* ]]; then
		local output=$(_fzf_config_insert_git)
		if [ "$output" = "__fallback" ]; then
			output=
			command="fd ."
			query=
			directory="$(git rev-parse --show-toplevel)/"
		elif [ -z "$output" ]; then
			zle reset-prompt
			return
		fi
	else
		query="$input_value"
		directory=
	fi

	if [ -z "$output" ]; then
		local output=$(
			eval \
				"${command:-fzf-default-command} ${directory:+\"${directory}\"} | \
				fzf \
				--height ${FZF_HEIGHT:-40%} \
				--query \"${query}\" \
				$FZF_CTRL_T_OPTS"
		)
	fi
	if [ -z "${output}" ]; then
		zle reset-prompt
		return
	fi

	outputString=""
	for item in "${output[@]}"; do
		[ -n "$item" ] && outputString="$outputString$(<<<$item tr '\n' ' ')"
	done
	LBUFFER="${LBUFFER%${input_value}}${outputString}"
	zle redisplay
}
# Customization
zle -N _fzf_config_insert
bindkey '^s' _fzf_config_insert


_fzf_config_git_insert() {
	local selection=$(git graph --color=always | fzf --no-sort)
	local hash=${selection##*, }
	if [ -n "$selection" ]; then
		LBUFFER="${LBUFFER}${hash}"
		zle redisplay
	fi

}
zle -N _fzf_config_git_insert
bindkey '^g' _fzf_config_git_insert

