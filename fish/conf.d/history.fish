not status -i || status -c && exit

set HISTIGNORE '^(history)( .*|$)|^(l|g)\s*$|^\s.*|^g push .*-f'

function fish_should_add_to_history
	string match -qr "$HISTIGNORE" -- $argv[1]; and return 1
	return 0
end

# sponge plugin
set sponge_purge_only_on_exit true


## bash/zsh like history selection (just select previous one)
#function _history-prev
#	if not commandline -S
#		commandline ""
#	end
#	commandline -f history-search-backward
#end
## up key
#bind \e\[A _history-prev

# support !! and !$
# https://superuser.com/questions/719530/what-is-the-equivalent-of-bashs-and-in-the-fish-shell/944589#944589
function bind_bang
	switch (commandline -t)[-1]
		case "!"
			commandline -t -- $history[1]
			commandline -f repaint
		case "*"
			commandline -i !
	end
end

function bind_dollar
	switch (commandline -t)[-1]
		case "!"
			commandline -f backward-delete-char history-token-search-backward
		case "*"
			commandline -i '$'
	end
end

function fish_user_key_bindings
	bind ! bind_bang
	bind '$' bind_dollar
end

