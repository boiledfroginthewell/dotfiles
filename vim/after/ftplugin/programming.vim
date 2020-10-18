" Programming Feature
set smartindent

augroup myfiletype_programming
	autocmd!
	" highlight the word under the cursor
	autocmd CursorMoved <buffer> exe printf('match Visual /\V\<%s\>/', escape(expand('<cword>'), '/\'))
augroup END

