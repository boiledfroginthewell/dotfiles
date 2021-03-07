set smartindent
set autoindent
set cindent
set tabstop=4
set shiftwidth=4
set noexpandtab
map <F6> :!xsel -o\|python %<CR>
map <F4> :!cat %\|xsel %<CR>

" Update PyFlakes
" noremap <buffer><silent> kk dd:PyflakesUpdate<CR>
" noremap <buffer><silent> kw dw:PyflakesUpdate<CR>
" noremap <buffer><silent> u u:PyflakesUpdate<CR>
" noremap <buffer><silent> <C-R> <C-R>:PyflakesUpdate<CR>

