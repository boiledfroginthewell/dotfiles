set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set noexpandtab
map <F12> ggI#!/usr/bin/env python<CR># vim: fileencoding=utf-8<ESC><C>o
map <F6> :!xsel -o\|python %<CR>
map <F4> :!cat %\|xsel %<CR>

" Update PyFlakes
" noremap <buffer><silent> kk dd:PyflakesUpdate<CR>
" noremap <buffer><silent> kw dw:PyflakesUpdate<CR>
" noremap <buffer><silent> u u:PyflakesUpdate<CR>
" noremap <buffer><silent> <C-R> <C-R>:PyflakesUpdate<CR>

