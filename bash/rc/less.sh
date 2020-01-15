# configuration for less
# editor for pager
export VISUAL="vim"

# syntax highlighting
if [ "$OSTYPE" != "msys" ]; then
	export LESS='-R'
	export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
fi

