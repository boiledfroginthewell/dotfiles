set nu
set display+=lastline
set autochdir
set autoindent
set background=light
set cursorline
set visualbell
set hlsearch " highlight search word
set infercase " ignore case when completing words
syntax on
highlight CursorLine term=underline ctermfg=NONE ctermbg=NONE

map <Space> <c-f>
map <s-Space> <c-b>
map <F2> :w<CR>:make<CR>
:command! Brol browse old
:command! Erc tabnew $MYVIMRC
:command! Egrc tabnew $MYGVIMRC

source ~/.vim/rc/dvorak_op.vim
source ~/.vim/rc/func.vim
source ~/.vim/rc/vundle.vim

"netrw Configuration
let g:netrv_altv = &spl
" netrwは常にtree view
let g:netrw_liststyle = 3
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END

function! NetrwMapping()
    noremap <buffer> t k
    noremap <buffer> T t
    noremap <buffer> o v
    noremap <buffer> O V
endfunction
