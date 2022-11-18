let s:path = $XDG_CONFIG_HOME . '/vim/after/ftplugin/programming.vim'
autocmd FileType
	\ {sh,bash,zsh,fish,c,cpp,python,hs,pgl,awk,xml,java,groovy,js,ts,tsx,vim,sql,hive}
	\ exec "source " . s:path

