not status -i || status -c && exit

set HISTIGNORE '^(sudo|history)( .*|$)|^(l|g)\s*$|^\s.*'

# HISTIGNORE support
# https://github.com/fish-shell/fish-shell/issues/5924#issuecomment-499414422
function should_add_history --on-event fish_postexec
	status is-command-substitution && exit

	string match -qr "$HISTIGNORE" -- $argv
	and history delete --exact --case-sensitive -- (string trim -r $argv)
end


# bash/zsh like history selection (just select previous one)
function _history-prev
	if not commandline -S
		commandline ""
	end
	commandline -f history-search-backward
end
# up key
bind \e\[A _history-prev

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

