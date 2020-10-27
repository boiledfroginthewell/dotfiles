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
		command="fd ."
		query=
		directory="$(git rev-parse --show-toplevel)/"
	else
		query="$input_value"
		directory=
	fi

	local output=$(
		eval \
			"${command:-fzf-default-command} \"$directory\" | \
			sed "s:^$directory::" | \
			fzf \
			--height ${FZF_TMUX_HEIGHT:-40%} \
			--query \"${query}\" \
			$FZF_CTRL_T_OPTS"
	)
	if [ -z "${output}" ]; then
		zle reset-prompt
		return
	fi

	outputString=""
	for item in "${output[@]}"; do
		[ -n "$item" ] && outputString="$outputString$(<<<$item tr '\n' ' ')"
	done
	LBUFFER="${LBUFFER%${query}}${outputString}"
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

