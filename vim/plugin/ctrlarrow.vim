function s:getLineText(text, column)
	if (strlen(a:text) <= a:column - 1)
		return -1
	else
		return a:text[a:column - 1]
	endif
endfunction

function! JumpSameLetters(direction)
	let line = line('.')
	let column = col('.')
	let lastline = line('$')
	let stepvalue = a:direction ? 1 : -1
	let currentChar = s:getLineText(getline('.'), column)
	while (0 < line && line <= lastline)
		let line = line + stepvalue
		if (currentChar != s:getLineText(getline(line), column) ||
					\ line == lastline)
			call cursor(line, column)
			return
		endif
	endwhile
endfunction

noremap <silent> <C-Up> :call JumpSameLetters(0)<CR>
noremap <silent> <C-Down> :call JumpSameLetters(1)<CR>

