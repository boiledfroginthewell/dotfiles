if [ "$OSTYPE" != "msys" ]; then
	type npm &> /dev/null && source <(npm completion)
fi

