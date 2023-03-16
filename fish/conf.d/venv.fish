not status -i || status -c && exit

function __activateVenv --on-event chpwd
	set venvs (rootSearch .venv)

	if [ -z "$venvs" ]
		if set -q VIRTUAL_ENV
			deactivate
		end
		return
	end

	if [ "$venvs" != "$VIRTUAL_ENV" ]
		source "$venvs/bin/activate.fish"
	end
end

__activateVenv

