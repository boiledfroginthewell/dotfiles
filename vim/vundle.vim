let s:vim_plug_dir = $XDG_CONFIG_HOME . '/vim/plugged'
" Specify a directory for plugins
"
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(s:vim_plug_dir)

" チートシート
let g:cheatsheet#cheat_file = $XDG_CONFIG_HOME . '/vim/cheatsheet.md'
let g:cheatsheet#vsplit = 1
let g:cheatsheet#vsplit_width = 35
noremap <leader>? :Cheat<CR>

if !has("win32unix")
	Plug 'thinca/vim-localrc'
endif

Plug 'editorconfig/editorconfig-vim'

Plug 'vim-scripts/ShowMarks'
let g:showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

if !has('win32unix') && !has('win32')
	" fzf heart vim
	Plug 'junegunn/fzf.vim'
	if filereadable("/usr/share/doc/fzf/examples/fzf.vim")
		source /usr/share/doc/fzf/examples/fzf.vim
	endif
	if isdirectory('/usr/local/opt/fzf')
		" MacOS
		set rtp+=/usr/local/opt/fzf
	endif
	nmap <silent> <Leader>r :Rg<CR>
	nmap <silent> <Leader>c :Commands<CR>
	nmap <silent> <Leader>b :Buffers<CR>
	command! Maps call fzf#vim#maps('', 0)<cr>
	command! FZFDEFAULT call fzf#run(fzf#wrap({}))
	nmap <silent> <Leader>, :FZFDEFAULT<CR>

	function! s:fzf_commandline()
		let l:BS = "\u08" " <C-h>
		let l:list = fzf#run(fzf#wrap({
			\ 'sink': { lines -> lines }
		\ }))
		if len(list)
			return escape(substitute(list[0], '^.\{-,},', '', ''), ' ')
		else
			return 'a' . l:BS " workaround for redraw problem
		endif
	endfunction
	cnoremap <expr> <C-S> <SID>fzf_commandline()
else
	Plug 'ctrlpvim/ctrlp.vim'
	let g:ctrlp_cmd = 'CtrlPMixed'
	if executable('fd')
		let g:ctrlp_user_command = 'fd -t f -c never "" %s'
		let g:ctrlp_use_caching = 0
	endif
endif


" quoting/parenthesizing made simple
Plug 'tpope/vim-surround'
let g:surround_no_mappings = 1
nmap ks  <Plug>Dsurround
nmap cs  <Plug>Csurround
nmap cS  <Plug>CSurround
nmap ys  <Plug>Ysurround
nmap yS  <Plug>YSurround
nmap yss <Plug>Yssurround
nmap ySs <Plug>YSsurround
nmap ySS <Plug>YSsurround
" xmap S   <Plug>VSurround
" xmap gS  <Plug>VgSurround

" vim-textobj-user - Create your own text objects
Plug 'kana/vim-textobj-user'

Plug 'jeetsukumaran/vim-indentwise'
map <C-t> <Plug>(IndentWiseBlockScopeBoundaryBegin)
map <C-h> <Plug>(IndentWiseBlockScopeBoundaryEnd)

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys =
\ 'EUOAI' .
\ 'F:L,R.C' .
\ '234789' .
\ ';QJKXVZWMBY' .
\ 'DSNTH'
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_add_search_history = 0
let g:EasyMotion_off_screen_search = 0
if has('mac')
	nmap - <Plug>(easymotion-bd-w)
else
	nmap - <Plug>(easymotion-overwin-w)
endif

" submode : Create your own submodes
Plug 'kana/vim-submode'


" Programming Plugins
"---------------------

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'

" Comment out
Plug 'tyru/caw.vim'
nmap <C-k> <Plug>(caw:hatpos:toggle)
vmap <C-k> <Plug>(caw:hatpos:toggle)

" sleuth.vim: Heuristically set buffer options 
Plug 'tpope/vim-sleuth'

Plug 'sbdchd/vim-shebang'
nmap <leader># :ShebangInsert<CR>
let g:shebang#shebangs = {
	\ 'sh': '#!/bin/bash',
\ }

if executable('ctags')
	Plug 'majutsushi/tagbar'
	nmap <F8> :TagbarToggle<CR>
	let g:tagbar_width = 30
	let g:tagbar_compact = 1
	let g:tagbar_iconchars = ['>', 'V']
	" sort by file order
	let g:tagbar_sort = 0
endif

Plug 'chaoren/vim-wordmotion'
let g:wordmotion_mappings = {
\ 'e' : 'w',
\ 'w' : 'e',
\ 'ge' : '',
\ 'ae' : '',
\ 'ie' : 'iw',
\ }
let g:wordmotion_spaces = '_-.'
nnoremap gw w
nnoremap ge e
nnoremap gb b

" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
Plug 'dense-analysis/ale'
highlight ALEWarning ctermbg=None
highlight ALEError ctermbg=None ctermfg=red

" XXX: YouCompleteMe
" Plug 'Valloric/YouCompleteMe'

" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}
if isdirectory(s:vim_plug_dir . '/coc.nvim')
	source $XDG_CONFIG_HOME/vim/coc/coc.rc.vim
endif
Plug 'honza/vim-snippets'


Plug 'vim-scripts/SingleCompile'
nmap <F5> :w<cr>:SCCompile<cr>
" nmap <F4> :w<cr>:SCCompileRun<cr>
"* gnuplot support
augroup vimrcSingleCompileGnuplot
	autocmd!
	autocmd FileType gnuplot * call SingleCompile#SetCompilerTemplate('gnuplot', 'gnuplot', 'gnuplotname', 'gnuplot', '', '')
	autocmd FileType gnuplot * call SingleCompile#ChooseCompiler('gnuplot', 'gnuplot')
augroup END

Plug 'janko/vim-test'
nmap <silent> <F6> :TestNearest<CR>
nmap <silent> <F7> :TestFile<CR>
" nmap <silent> t<C-s> :TestSuite<CR>
" nmap <silent> t<C-l> :TestLast<CR>
" nmap <silent> t<C-g> :TestVisit<CR>


" Language Specific Plugins
" -------------------------

" C
" ---
Plug 'jceb/vim-hier', {'for': ['c', 'cpp']}


call plug#end()

if isdirectory(s:vim_plug_dir . '/vim-submode')
	" ### Submode configuration
	let g:submode_keep_leaving_key=1
	call submode#enter_with('tab', 'n', '', 'gt', 'gt')
	call submode#enter_with('tab', 'n', '', 'gT', 'gT')
	call submode#map('tab', 'n', '', 't', 'gt')
	call submode#map('tab', 'n', '', 'T', 'gT')
	call submode#enter_with('window', 'n', '', '<c-w>-', '<c-w>-')
	call submode#enter_with('window', 'n', '', '<c-w>+', '<c-w>+')
	call submode#enter_with('window', 'n', '', '<c-w><', '<c-w><')
	call submode#enter_with('window', 'n', '', '<c-w>>', '<c-w>>')
	call submode#map('window', 'n', '', '-', '<c-w>-')
	call submode#map('window', 'n', '', '+', '<c-w>+')
	call submode#map('window', 'n', '', '<', '<c-w><')
	call submode#map('window', 'n', '', '>', '<c-w>>')
endif
