if [[ "$OSTYPE" = "darwin"* ]]; then
	# GitHub Cloneしてインストールしたときのみ必要. macでは不要
	export PYENV_ROOT="$HOME/opt/pyenv"
	export PATH="$PYENV_ROOT/bin:$PATH"
fi

if which pyenv > /dev/null; then
	eval "$(pyenv init -)"
	eval "$(pyenv virtualenv-init -)"
fi

