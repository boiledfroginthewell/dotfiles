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

if !exists('g:cheatsheet#state_cache_seconds')
  let g:cheatsheet#state_cache_seconds = 30 * 60
endif

command! -nargs=? -complete=command Cheat call <SID>toggle_cheat_sheet(<q-args>)
command! -nargs=? -complete=command CheatInit call <SID>init_cheat_sheet()
command! -nargs=? -complete=command CheatOpen call <SID>open_cheat_sheet(<q-args>)
command! -nargs=? -complete=command CheatClose call <SID>close_cheat_sheet(<q-args>)

" Save open state
" let s:cache_dir = ("$XDG_CACHE_HOME" ?? ("$HOME" . "/.config")) . "/vim-cheatsheet"
let s:cache_dir = $XDG_CACHE_HOME . "/vim-cheatsheet"
let s:cache_file = s:cache_dir . "/state"

function! s:write_state(state)
 call  writefile([a:state, localtime()], s:cache_file)
endfunction


if !exists('g:cheatsheet#no_auto_open')
    augroup cheatsheet
        autocmd!
        autocmd VimEnter * if winwidth(0) >= 90| CheatInit| endif
        autocmd bufenter * if (winnr("$") == 1 && exists("t:cheatbuf")) | q | endif
        autocmd VimResized,WinNew,WinEnter,WinLeave * call s:resize_cheat_sheet()
    augroup END
endif

function! s:resize_cheat_sheet()
    if !exists('t:cheatbuf')
        return
    elseif g:cheatsheet#vsplit == 0
        return
    endif

    execute 'vertical ' . t:returnWinnr . 'resize ' . g:cheatsheet#vsplit_width
endfunction

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

function! s:init_cheat_sheet() abort
  " read and create cache
  if filereadable(s:cache_file)
    let l:cache_state = readfile(s:cache_file)
  else
    let l:cache_state = [1, 0]
    if !isdirectory(s:cache_dir)
      call mkdir(s:cache_dir)
    endif
  endif

  " Open cheatsheet if not recently closed
  if l:cache_state[0] || localtime() - str2nr(l:cache_state[1]) > g:cheatsheet#state_cache_seconds
    let t:cheatbuf = s:open_cheat_sheet()
  endif
endfunction

function! s:open_cheat_sheet() abort
  let l:path = expand(g:cheatsheet#cheat_file)

  if !filereadable(l:path)
    echo 'not exists.'
    return
  endif

  call s:write_state(1)

  let l:split_command = ':belowright sp'
  if g:cheatsheet#vsplit != 0
    let l:split_command = ':belowright ' . g:cheatsheet#vsplit_width . 'vs'
  endif
  execute l:split_command
  execute 'view' l:path
  let t:returnWinnr = win_getid()
  let returnBufnr = bufnr('%')
  set nonu
  set nocursorline
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
  " set winfixwidth
  " q = :Cheat
  nnoremap <buffer> <silent> q :<C-u>CheatClose<CR>
  return bufnr('%')
endfunction

function! s:close_cheat_sheet(cheatbuf) abort
  if exists('t:cheatbuf')
    execute 'bd' t:cheatbuf
    unlet! t:cheatbuf
  endif
  call s:write_state(0)
endfunction
