let s:path = expand('<sfile>:p:h') . '/myftplugin.vim'
augroup rcCustomeFtdetect
	autocmd!
	autocmd FileType
		\ {c,cpp,python,hs,pgl,awk,js,ts,vim}
		\ exec "source " . s:path
augroup END

