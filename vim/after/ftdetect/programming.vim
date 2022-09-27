let s:path = $XDG_CONFIG_HOME . '/vim/after/ftplugin/programming.vim'
autocmd FileType
	\ {sh,bash,zsh,fish,c,cpp,python,hs,pgl,awk,js,ts,tsx,vim}
	\ exec "source " . s:path

