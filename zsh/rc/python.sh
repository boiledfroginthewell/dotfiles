alias ipython="ipython --no-confirm-exit"

if type pyenv &>/dev/null; then
	eval "$(pyenv init -)"
	export PYTHONPATH="$PYTHONPATH:."
fi

