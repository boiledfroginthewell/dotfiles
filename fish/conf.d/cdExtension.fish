not status -i || status -c && exit

set -g __chpwd_prev "$PWD"
function emitChpwd --on-variable PWD
	status is-command-substitution && exit

	# on-variable hook is called even if the same value is set again
	if [ "$__chpwd_prev" != "$PWD" ]
		emit chpwd1 $argv "$__chpwd_prev" "$PWD"
		emit chpwd $argv "$__chpwd_prev" "$PWD"
		set -g __chpwd_prev "$PWD"
	end
end

function emitChpwdFirst --on-event fish_prompt
	emit chpwd0
	emit chpwd
	functions --erase emitChpwdFirst
end

function autols --on-event chpwd1
	ls
end

alias zc="z -c"

