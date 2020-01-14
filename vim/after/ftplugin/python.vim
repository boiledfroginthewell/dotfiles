set smartindent
set autoindent
set cindent
set tabstop=4
set shiftwidth=4
set noexpandtab
map <F12> ggI#!/usr/bin/env python<CR># vim: fileencoding=utf-8<ESC><C>o
map <F6> :!xsel -o\|python %<CR>
map <F4> :!cat %\|xsel %<CR>

" highlight the word under the cursor
autocmd CursorMoved *.py exe printf('match Visual /\V\<%s\>/', escape(expand('<cword>'), '/\'))

" Update PyFlakes 
" noremap <buffer><silent> kk dd:PyflakesUpdate<CR>
" noremap <buffer><silent> kw dw:PyflakesUpdate<CR>
" noremap <buffer><silent> u u:PyflakesUpdate<CR>
" noremap <buffer><silent> <C-R> <C-R>:PyflakesUpdate<CR>

" ====== jedi-vim with neocomplete ========
let g:jedi#completions_enabled = 1
let g:jedi#auto_vim_configuration = 1
let g:neocomplete#sources#syntax#min_keyword_length = 0

if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

