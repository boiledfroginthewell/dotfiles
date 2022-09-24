export FZF_DEFAULT_OPTS="--reverse --multi --cycle --ansi --bind "ctrl-a:toggle-all""
export FZF_DEFAULT_COMMAND=fzf-default-command

KEY_BINDING_FILE=/usr/share/doc/fzf/examples/key-bindings.$(basename $SHELL)
if [ -e "$KEY_BINDING_FILE" ]; then
	# Disable C-t Mapping
	source <(< $KEY_BINDING_FILE sed 's/.*bindkey .*\^T.*/:/')
fi
FZF_CTRL_T_OPTS='--bind "ctrl-l:execute(l {} > /dev/tty )"'

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
		branch|switch)
			_fzf_config_select_git_ref
			return
			;;
		*)
			echo __fallback
			return
			;;
	esac
}

_fzf_config_ctrl_s() {
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
	elif [[ "$LBUFFER" =~ "^\s*g(it)? " ]]; then
		local output=$(_fzf_config_insert_git)
		if [ "$output" = "__fallback" ]; then
			output=
			command="fd ."
			query=
			directory=$(<<<"$(git rev-parse --show-toplevel)/" sed s:"^$PWD":"./":)
		elif [ -z "$output" ]; then
			zle reset-prompt
			return
		fi
	else
		query="$input_value"
		directory=
	fi

	if [ -z "$output" ]; then
		local -a output=($(
			eval \
				"${command:-fzf-default-command} ${directory:+\"${directory}\"} | \
				fzf \
				--height ${FZF_HEIGHT:-40%} \
				--query \"${query}\" \
				$FZF_CTRL_T_OPTS"
		))
	fi
	if [ -z "${output}" ]; then
		zle reset-prompt
		return
	fi

	outputString=""
	for item in ${output[@]}; do
		[ -n "$item" ] && outputString="$outputString$(printf "%q " $(<<<$item tr "\n" " ") | sed 's/^\\~/~/')"
	done
	LBUFFER="${LBUFFER%${input_value}}${outputString}"
	zle redisplay
}
zle -N _fzf_config_ctrl_s
bindkey '^s' _fzf_config_ctrl_s


_fzf_config_select_git_hash() {
	local selection=$(git graph --color=always | fzf --no-sort | sed -e 's;\s$;;' -e 's;.* ;;')
	if [ -n "$selection" ]; then
		LBUFFER="${LBUFFER}${selection}"
		zle redisplay
	fi
}
zle -N _fzf_config_select_git_hash
bindkey '^g^l' _fzf_config_select_git_hash

_fzf_config_select_git_ref() {
	cat \
		<(git branch -a --color | sed -e 's:remotes/::' -e 's:^:[branch] :') \
		<(git tag -l | sed 's:^:[tag] :') \
	| fzf --no-sort --preview 'git log --color --oneline $(echo {} | sd ".* " "")' --height 40% \
	| sd '\[\w+\] [\s*]*' ''
}
_zle_fzf_config_select_git_ref() {
	local -a selection=( $(_fzf_config_select_git_ref) )
	if [ -n "$selection" ]; then
		LBUFFER="${LBUFFER}${selection[@]}"
		zle redisplay
	fi
}
zle -N _zle_fzf_config_select_git_ref
bindkey '^g^r' _zle_fzf_config_select_git_ref

