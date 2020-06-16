# configuration for less
# editor for pager
export VISUAL="vim"

# syntax highlighting
if [ "$OSTYPE" != "msys" ]; then
	export LESS='-R'

	if [ -e "/usr/local/bin/src-hilite-lesspipe.sh" ]; then
		# Mac
		export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
	else
		export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
	fi
fi

