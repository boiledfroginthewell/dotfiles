" Programming Feature
set smartindent

augroup myfiletype
	autocmd!
	" highlight the word under the cursor
	autocmd CursorMoved * exe printf('match Visual /\V\<%s\>/', escape(expand('<cword>'), '/\'))
augroup END

