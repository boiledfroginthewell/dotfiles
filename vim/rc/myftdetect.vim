let s:path = expand('<sfile>:p:h') . '/myftplugin.vim'
augroup rcCustomeFtdetect
	autocmd!
	autocmd FileType
		\ {c,cpp,py,hs,pgl,awk,js,vim}
		\ exec "source " . s:path
augroup END

