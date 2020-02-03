augroup myfiletypedetect
	au!
	au BufRead,BufNewFile
		\ *.{c,cpp,py,hs,gpl,awk,js,vim}
		\ exe "setlocal filetype+=.programming"
augroup END
