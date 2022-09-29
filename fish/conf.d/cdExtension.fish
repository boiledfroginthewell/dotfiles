not status -i || status -c && exit

set -g __chpwd_prev "$PWD"
function emitChpwd --on-variable PWD
	# on-variable hook is called even if the same value is set again
	if [ "$__chpwd_prev" != "$PWD" ]
		emit chpwd $argv "$__chpwd_prev" "$PWD"
		set -g __chpwd_prev "$PWD"
	end
end

function autols --on-event chpwd
	ls
end

alias zc="z -c"

