
__duplicate_last_arg() {
	local CMD_LINE="${READLINE_LINE}"
	CMD_LINE=${CMD_LINE%% }
	local LAST_ARG="${CMD_LINE##* }"

	READLINE_LINE="${CMD_LINE} ${LAST_ARG}"
	READLINE_POINT=0x7fffffff
}

bind -x '"\C-n": __duplicate_last_arg'

