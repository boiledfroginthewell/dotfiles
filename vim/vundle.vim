" Vim Plugin Configuration
" ===========================
let s:vim_plug_dir = $XDG_CONFIG_HOME . '/vim/plugged'
" Specify a directory for plugins
"
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(s:vim_plug_dir)

" General Plugins
" -----------------
" ### Cheat sheet
let g:cheatsheet#cheat_file = $XDG_CONFIG_HOME . '/vim/cheatsheet.md'
let g:cheatsheet#vsplit = 1
let g:cheatsheet#vsplit_width = 35
noremap <leader>? :Cheat<CR>

Plug 'editorconfig/editorconfig-vim'

Plug 'vim-scripts/ShowMarks'
let g:showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

" Update v:oldfiles on opening buffer
Plug 'gpanders/vim-oldfiles'

if !has('win32unix') && !has('win32')
	" fzf heart vim
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	function! s:swap_buffer(lines)
		let l:buf = bufnr('%')
		exec 'e '.a:lines[0]
		exec 'bd '.l:buf
	endfunction
	function! s:edit_selection(lines)
		call feedkeys(':e ' . join(a:lines, ' '))
	endfunction
	let g:fzf_action = {
		\'ctrl-n': function('s:swap_buffer'),
		\'ctrl-e': function('s:edit_selection'),
	\ }
	augroup myrcFzfConfig
		function! s:configureFzfPopup()
			if &background == "dark"
				hi MyrcFzfPopup ctermbg=237
				hi MyrcFzfPopupBorder term=bold cterm=bold ctermfg=blue
				let g:fzf_colors = {
					\'bg': ['bg', 'MyrcFzfPopup'],
					\'fg+': ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
					\'bg+': ['bg', 'CursorLine', 'CursorColumn'],
					\'border': ['fg', 'MyrcFzfPopupBorder'],
				\}
			endif
		endfunction
		autocmd!
		autocmd VimEnter * call s:configureFzfPopup()
	augroup END
	nmap <silent> <Leader>r :Rg<CR>
	nmap <silent> <Leader>c :Commands<CR>
	nmap <silent> <Leader>b :Buffers<CR>
	" Include all mode
	command! Maps call fzf#vim#maps('', 0)<cr>
	nmap <silent> <Leader>, :call fzf#run(fzf#wrap({
		\'source': 'bash -c "'.
			\'echo -e \"'.join(v:oldfiles, '\n').'\";'.
			\'fzf-default-command;'.
			\'"',
		\'dir': '.',
	\}))<CR>

	function! s:fzf_commandline()
		let l:BS = "\u08" " <C-h>
		let l:list = fzf#run(fzf#wrap({
			\'source': 'bash -c "'.
				\'echo -e \"'.join(v:oldfiles, '\n').'\";'.
				\'fzf-default-command;'.
				\'"',
			\'dir': '.',
			\ 'sink': { lines -> lines },
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
xmap S   <Plug>VSurround
xmap gS  <Plug>VgSurround

" vim-textobj-user - Create your own text objects
Plug 'kana/vim-textobj-user'

Plug 'inkarkat/argtextobj.vim'
Plug 'thalesmello/vim-textobj-methodcall'

Plug 'jeetsukumaran/vim-indentwise'
let g:indentwise_skip_blanks = 1
map <silent><expr> <C-t> <SID>indentwise_is_top_level() ?
	\ '{' : '<Plug>(IndentWiseBlockScopeBoundaryBegin)'
map <silent><expr> <C-h> <SID>indentwise_is_top_level() ?
	\ "}" : '<Plug>(IndentWiseBlockScopeBoundaryEnd)'
function! s:indentwise_is_top_level() abort
	let first_char = getline('.')[0]
	return first_char == '' || first_char =~ '\S'
endfunction

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

" diff markers in the sign column and stages/previews/undoes hunks and partial hunks.
Plug 'airblade/vim-gitgutter'
let g:gitgutter_diff_args = '--ignore-all-space'


" Programming Plugins
"---------------------

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'
set conceallevel=0
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:polyglot_disabled = ['python-indent', 'csv']

Plug 'tpope/vim-fugitive'

" Comment out
Plug 'tyru/caw.vim'
nmap <C-k> <Plug>(caw:hatpos:toggle)
vmap <C-k> <Plug>(caw:hatpos:toggle)

" ALE already supports vim-sleuth
" " Indent
" Plug 'ciaranm/detectindent'
" augroup vimrc_indent
" 	autocmd!
" 	autocmd BufReadPost * :DetectIndent
" augroup END

" Color brackets
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
if &background == "light"
	let darkcolors = ['DarkBlue', 'Magenta', 'Black', 'Red', 'DarkGray', 'DarkGreen', 'DarkYellow']
	let g:rainbow_conf = {
	\   'ctermfgs': darkcolors,
	\   'guifgs': darkcolors
	\}
endif


" Visualise space indents
Plug 'Yggdroot/indentLine'
let g:indentLine_char = '¦'

Plug 'sbdchd/vim-shebang'
nmap <leader># :ShebangInsert<CR>
let g:shebang#shebangs = {
	\ 'sh': '#!/bin/bash',
	\ 'bash': '#!/bin/bash',
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
let g:wordmotion_nomap = 1
" let g:wordmotion_mappings = {
"\ 'e' : 'w',
"\ 'w' : 'e',
"\ 'ge' : '',
"\ 'ae' : '',
"\ 'ie' : 'iw',
"\ }
let g:wordmotion_spaces = '_-.'
map e <Plug>WordMotion_w
map w <Plug>WordMotion_e
map b <Plug>WordMotion_b
omap e <Plug>WordMotion_e
omap w <Plug>WordMotion_w
omap b <Plug>WordMotion_b
nnoremap gw w
nnoremap ge e
nnoremap gb b

" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support
let g:ale_disable_lsp = 1
Plug 'dense-analysis/ale'
let g:ale_linters = { 'python': ['flake8', 'mypy', 'isort'] }
highlight ALEWarning ctermbg=None
highlight ALEError ctermbg=None ctermfg=red
" nmap <silent> <C-t> <Plug>(ale_previous_wrap)
" nmap <silent> <C-h> <Plug>(ale_next_wrap)

" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
if executable('node')
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	if isdirectory(s:vim_plug_dir . '/coc.nvim')
		source $XDG_CONFIG_HOME/vim/coc/coc.rc.vim
	endif
	Plug 'honza/vim-snippets'
endif


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

" ### C
Plug 'jceb/vim-hier', {'for': ['c', 'cpp']}

" ### JSON
Plug 'rhysd/vim-fixjson', {'for': 'json'}
let g:fixjson_fix_on_save = 0

" ### KMonad
Plug 'kmonad/kmonad-vim'

" ### Linux
Plug 'wgwoods/vim-systemd-syntax'

call plug#end()

if isdirectory(s:vim_plug_dir . '/vim-textobj-user')
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
endif

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
	call submode#enter_with('window', 'n', '', '<c-w>d', '<c-w>h')
	call submode#enter_with('window', 'n', '', '<c-w>h', '<c-w>j')
	call submode#enter_with('window', 'n', '', '<c-w>t', '<c-w>k')
	call submode#enter_with('window', 'n', '', '<c-w>n', '<c-w>l')
	call submode#map('window', 'n', '', '-', '<c-w>-')
	call submode#map('window', 'n', '', '+', '<c-w>+')
	call submode#map('window', 'n', '', '<', '<c-w><')
	call submode#map('window', 'n', '', '>', '<c-w>>')
	call submode#map('window', 'n', '', 'd', '<c-w>h')
	call submode#map('window', 'n', '', 'h', '<c-w>j')
	call submode#map('window', 'n', '', 't', '<c-w>k')
	call submode#map('window', 'n', '', 'n', '<c-w>l')
endif

