" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin($XDG_CONFIG_HOME . '/vim/plugged')

Plug $XDG_CONFIG_HOME . '/vim/plugin/reireias/vim-cheatsheet'
let g:cheatsheet#cheat_file = $XDG_CONFIG_HOME . '/vim/cheatsheet.md'
let g:cheatsheet#vsplit = 1
let g:cheatsheet#vsplit_width = 35
autocmd VimEnter * Cheat
autocmd bufenter * if (winnr("$") == 1 && exists("t:cheatbuf")) | q | endif

Plug 'vim-scripts/project.tar.gz'
Plug 'vim-scripts/restart.vim', {'on': 'Restart'}
" 終了時に保存するセッションオプションを設定する
let g:restart_sessionoptions
    \ = 'blank,buffers,curdir,folds,help,localoptions,tabpages'

" fzf heart vim
Plug 'junegunn/fzf.vim'
if has("unix") && !has("win32unix")
	source /usr/share/doc/fzf/examples/fzf.vim
endif

Plug 'vim-scripts/ShowMarks'
let g:showmarks_include = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

Plug 'thinca/vim-localrc'
Plug 'editorconfig/editorconfig-vim'

Plug 'vim-scripts/SingleCompile'
"---------------------
nmap <F5> :w<cr>:SCCompile<cr>
" nmap <F4> :w<cr>:SCCompileRun<cr>
"* gnuplot support
"call SingleCompile#SetCompilerTemplate('gnuplot', 'gnuplot', 'gnuplotname', 'gnuplot', '', '')
"call SingleCompile#ChooseCompiler('gnuplot', 'gnuplot')

Plug 'janko/vim-test'
nmap <silent> <F6> :TestNearest<CR>
nmap <silent> <F7> :TestFile<CR>
" nmap <silent> t<C-s> :TestSuite<CR>
" nmap <silent> t<C-l> :TestLast<CR>
" nmap <silent> t<C-g> :TestVisit<CR>

" Comment out
Plug 'tyru/caw.vim'
nmap <C-k> <Plug>(caw:hatpos:toggle)
vmap <C-k> <Plug>(caw:hatpos:toggle)


" Plug 'majutsushi/tagbar'
" nmap <F8> :TagbarToggle<CR>
" let g:tagbar_width = 30
" let g:tagbar_compact = 1
" let g:tagbar_iconchars = ['>', 'V']
" " sort by file order
" let g:tagbar_sort = 0

Plug 'vim-scripts/camelcasemotion'
autocmd FileType programming * map <silent> <buffer> e <Plug>CamelCaseMotion_w
autocmd FileType programming * map <silent> <buffer> w <Plug>CamelCaseMotion_e
autocmd FileType programming * map <silent> <buffer> b <Plug>CamelCaseMotion_b


Plug 'Shougo/neocomplete.vim'
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Recommended key-mappings for neocomplete.
" --------------------------
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
inoremap <expr><Space> neocomplete#close_popup() . "\<Space>"
" Plug key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()


" TODO : ustilize polyglot or ale
" Plug 'scrooloose/syntastic'
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" " no checker for js is install in this computer
" let g:syntastic_javascript_checkers = ['jshint']
" let g:syntastic_python_checkers = ["flake8"]

" A solid language pack for Vim. 
Plug 'sheerun/vim-polyglot'

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'
nmap - <Plug>(easymotion-overwin-w)

" Language Specific Plugins
" ========================
" Setting for these plugins are written under ftplugin/
"
" markdown
" --------
Plug 'previm/previm'
Plug 'tyru/open-browser.vim'
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
 
au BufRead,BufNewFile *.md set filetype=markdown

" C
" ---
Plug 'jceb/vim-hier', {'for': ['c', 'cpp']}

" Python
" --------
Plug 'davidhalter/jedi-vim', {'for': 'python'}
let g:jedi#documentation_command = "T"
autocmd FileType python setlocal completeopt-=preview
" jedi-vim with neocomplete
autocmd FileType python setlocal omnifunc=jedi#python3completions
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}

" JavaScript
" -----------------
Plug 'othree/yajs.vim', {'for': 'js'}
Plug 'ternjs/tern_for_vim', {'for': 'js'}
" Plug 'Valloric/YouCompleteMe'
Plug 'othree/javascript-libraries-syntax.vim', {'for': 'js'}
" au FileType javascript noremap <F3> :TernDef<CR>
" au FileType javascript inoremap <F3> :TernDef<CR>

Plug 'maksimr/vim-jsbeautify', {'for': 'js'}

" html
" -----------------
Plug 'othree/html5.vim', {'for': 'html'}

call plug#end()

