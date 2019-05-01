setlocal tabstop=4
setlocal shiftwidth=4

" highlight the word under the cursor
autocmd CursorMoved *.js exe printf('match Visual /\V\<%s\>/', escape(expand('<cword>'), '/\'))
" autocmd CursorMoved *.js TernType

noremap <buffer> <C-f> :call JsBeautify()<CR>

TagbarOpen j<CR>
