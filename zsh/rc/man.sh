myrc_help() {
	cmd=$(<<<"${BUFFER}" sed -e 's/.*[;&|]\s*//' -e 's/^\(\S\+\).*/\1/')
	if [ -z "$cmd" ]; then
		return
	fi
	men $cmd
	zle redisplay
}

zle -N myrc_help
# F1 key
bindkey 'OP' myrc_help
