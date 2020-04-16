" Specify a directory for plugins
"
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin($XDG_CONFIG_HOME . '/vim/plugged')

" チートシート
Plug $XDG_CONFIG_HOME . '/vim/plugin/reireias/vim-cheatsheet'
let g:cheatsheet#cheat_file = $XDG_CONFIG_HOME . '/vim/cheatsheet.md'
let g:cheatsheet#vsplit = 1
let g:cheatsheet#vsplit_width = 35
noremap <leader>? :Cheat<CR>

if !has("win32unix")
	Plug 'thinca/vim-localrc'
endif

Plug 'editorconfig/editorconfig-vim'

Plug 'vim-scripts/restart.vim', {'on': 'Restart'}
" 終了時に保存するセッションオプションを設定する
let g:restart_sessionoptions
    \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

Plug 'vim-scripts/ShowMarks'
let g:showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

if !has('win32unix') && !has('win32')
	" fzf heart vim
	Plug 'junegunn/fzf.vim'
	if filereadable('/usr/share/doc/fzf/example/fzf.vim')
		source '/usr/share/doc/fzf/examples/fzf.vim'
	endif
	if filereadable('/usr/local/opt/fzf')
		" MacOS
		set rtp+=/usr/local/opt/fzf
	endif
	nmap <silent> <Leader>r :Rg 
	nmap <silent> <Leader>, :Commands<CR>
	command! Maps call fzf#vim#maps('', 0)<cr>
	function! s:get_git_root()
	  let root = split(system('git rev-parse --show-toplevel'), '\n')[0]
	  return v:shell_error ? '' : root
	endfunction
	command! FZFMix call fzf#run(fzf#wrap({
				\'source':  'bash -c "'.
				\				'echo -e \"'.join(v:oldfiles, '\n').'\";'.
				\				'find --type f \"\"'.
				\			'"',
				\'dir': s:get_git_root(),
			\}))
	nmap <silent> <Leader>o :FZFMix<CR>
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

" Extended f, F, t and T key mappings for Vim.
Plug 'rhysd/clever-f.vim'
let g:clever_f_not_overwrites_standard_mappings = 1
nmap j <Plug>(clever-f-f)
xmap j <Plug>(clever-f-f)
omap j <Plug>(clever-f-f)
nmap J <Plug>(clever-f-F)
xmap J <Plug>(clever-f-F)
omap J <Plug>(clever-f-F)
" nmap ; <Plug>(clever-f-f)
" xmap ; <Plug>(clever-f-f)
" omap ; <Plug>(clever-f-f)

" The missing motion for Vim
Plug 'justinmk/vim-sneak'
map <C-s> <Plug>Sneak_s
omap <C-s> <Plug>Sneak_s
xmap <C-s> <Plug>Sneak_s
map <C-J> <Plug>Sneak_S
omap <C-J> <Plug>Sneak_S
xmap <C-J> <Plug>Sneak_S
" Prevent mapping. (Sneak overwrites maps if not already mapped.)
nmap <F20> <Plug>SneakForward
nmap <F21> <Plug>SneakBackward
nmap <F22> <Plug>Sneak_

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_use_upper = 1
let g:EasyMotion_keys =
\ 'EUOAI' .
\ 'F:L,R.C' .
\ '2346789' .
\ ';QJKXVZWMBY' .
\ 'DSNTH'
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_add_search_history = 0
let g:EasyMotion_off_screen_search = 0
nmap - <Plug>(easymotion-overwin-w)



" Programming Plugins
"---------------------

" A solid language pack for Vim.
Plug 'sheerun/vim-polyglot'

" Comment out
Plug 'tyru/caw.vim'
nmap <C-k> <Plug>(caw:hatpos:toggle)
vmap <C-k> <Plug>(caw:hatpos:toggle)


if executable('ctags')
	Plug 'majutsushi/tagbar'
	nmap <F8> :TagbarToggle<CR>
	let g:tagbar_width = 30
	let g:tagbar_compact = 1
	let g:tagbar_iconchars = ['>', 'V']
	" sort by file order
	let g:tagbar_sort = 0
endif

Plug 'vim-scripts/camelcasemotion'
augroup vimrcCamelCaseMotion
	autocmd!
	autocmd FileType programming * map <silent> <buffer> e <Plug>CamelCaseMotion_w
	autocmd FileType programming * map <silent> <buffer> w <Plug>CamelCaseMotion_e
	autocmd FileType programming * map <silent> <buffer> b <Plug>CamelCaseMotion_b
augroup END

" Check syntax in Vim asynchronously and fix files, with Language Server Protocol (LSP) support 
Plug 'dense-analysis/ale'

" XXX: YouCompleteMe
" Plug 'Valloric/YouCompleteMe'

" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', {'branch': 'release'}
if filereadable($XDG_CONFIG_HOME.'/vim/plug/coc.nvim')
	source $XDG_CONFIG_HOME/vim/rc/coc.rc.vim
	let g:coc_snippet_next = '<tab>'
	let g:coc_snippet_prev = '<s-tab>'
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

