not status -i || status -c && exit

function __update_active_venv -e chpwd
	status is-command-substitution && return

	if set -q __venv_active_prefix && string match -qr "$__venv_active_prefix(/.*|\$)" "$PWD"
		# already in venv
		return
	end

	set pathToRoot "$PWD"
	while not [ -r "$pathToRoot"/pyproject.toml ]
		if [ "$pathToRoot" = "/" ]
			if set -q VIRTUAL_ENV
				set -ge __venv_active_prefix
				deactivate
			end
			return
		end
		set pathToRoot (dirname "$pathToRoot")
	end

	set -g __venv_active_prefix "$pathToRoot"
	__enter_venv
end

function __enter_venv
	# NOTE: poetry env info command is slow
	set venvPath (poetry env info --path)
	if [ "$venvPath" = "$VIRTUAL_ENV" ]
		# already in venv
		return
	else if set -q VIRTUAL_ENV
		# currently in anorther venv
		deactivate
	end

	source "$venvPath"/bin/activate.fish
end

