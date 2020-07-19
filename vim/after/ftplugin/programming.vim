" Programming Feature
set smartindent

augroup myfiletype_programming
	autocmd!
	" highlight the word under the cursor
	autocmd CursorMoved <buffer> exe printf('match Visual /\V\<%s\>/', escape(expand('<cword>'), '/\'))
augroup END

call textobj#user#plugin('spaces', {
\   'space-a': {
\     'pattern': '\s*\S\+\s*',
\     'select': 'a<Space>',
\     'scan': 'cursor',
\   },
\   'space-i': {
\     'pattern': '[^ \t]\+',
\     'select': 'i<Space>',
\     'scan': 'line',
\   }
\ })

