" Set settings to default values.
if !exists('g:cheatsheet#vsplit')
  let g:cheatsheet#vsplit = 0
endif

if !exists('g:cheatsheet#vsplit_width')
  let g:cheatsheet#vsplit_width = ''
endif

if !exists('g:cheatsheet#float_window')
  let g:cheatsheet#float_window = 0
endif

if !exists('g:cheatsheet#float_window_width_ratio')
  let g:cheatsheet#float_window_width_ratio = 0.8
endif

if !exists('g:cheatsheet#float_window_height_ratio')
  let g:cheatsheet#float_window_height_ratio = 0.9
endif

command! -nargs=? -complete=command Cheat call <SID>toggle_cheat_sheet(<q-args>)

if !exists('g:cheatsheet#no_auto_open')
	augroup cheatsheet
		autocmd!
		autocmd cheatsheet VimEnter * Cheat
		autocmd cheatsheet bufenter * if (winnr("$") == 1 && exists("t:cheatbuf")) | q | endif
	augroup END
endif

function! s:toggle_cheat_sheet(cmd)
  if exists('t:cheatbuf')
    call s:close_cheat_sheet(t:cheatbuf)
    unlet! t:cheatbuf
  else
    if g:cheatsheet#float_window == 0
      let t:cheatbuf = s:open_cheat_sheet()
    else
      let t:cheatbuf = s:open_cheat_sheet_float()
    endif
  endif
endfunction

function! s:open_cheat_sheet() abort
  let l:path = expand(g:cheatsheet#cheat_file)

  if !filereadable(l:path)
    echo 'not exists.'
    return
  endif

  let l:split_command = ':belowright sp'
  if g:cheatsheet#vsplit != 0
    let l:split_command = ':belowright ' . g:cheatsheet#vsplit_width . 'vs'
  endif
  execute l:split_command
  execute 'view' l:path
  let returnBufnr = bufnr('%')
  set nonu
  wincmd w
  return returnBufnr
endfunction

function! s:open_cheat_sheet_float() abort
  let buf = nvim_create_buf(v:false, v:true)
  let width = float2nr(round(winwidth(0) * g:cheatsheet#float_window_width_ratio))
  let height = float2nr(round(winheight(0) * g:cheatsheet#float_window_height_ratio))
  " can move in float window?
  let focusable = v:true
  " editor or win or cursor
  let relative = 'win'
  " base position
  let anchor = 'NW'
  " offset
  let row = float2nr(round(winheight(0) * (1 - g:cheatsheet#float_window_height_ratio) / 2))
  let col = float2nr(round(winwidth(0) * (1 - g:cheatsheet#float_window_width_ratio) / 2))
  let opts = {
        \ 'relative': relative,
        \ 'anchor': anchor,
        \ 'height': height,
        \ 'width': width,
        \ 'row': row,
        \ 'col': col
        \ }
  let winid = nvim_open_win(buf, v:true, opts)
  let l:path = expand(g:cheatsheet#cheat_file)
  execute 'view' l:path
  " q = :Cheat
  nnoremap <buffer> <silent> q :<C-u>Cheat<CR>
  return bufnr('%')
endfunction

function! s:close_cheat_sheet(cheatbuf) abort
  execute 'bd' a:cheatbuf
endfunction
