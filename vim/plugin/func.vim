" Reload .vimrc/.gvimrc after saving .vimrc
" .vimrcの再読込時にも色が変化するようにする
augroup MyAutoCmd
    autocmd!

	if has("nvim")
        autocmd MyAutoCmd BufWritePost init.lua,*/dotfiles/nvim/**/*.lua,*/dotfiles/nvim/**/*.vim nested luafile $XDG_CONFIG_HOME/nvim/init.lua
	elseif !has('gui_running') && !(has('win32') || has('win64'))
        autocmd MyAutoCmd BufWritePost vimrc,vundle.vim,*/vim/plugin/*.vim,*/vim/*.rc.vim nested source $MYVIMRC
    else
        autocmd MyAutoCmd BufWritePost vimrc,vundle.vim,*/vim/plugin/*.vim,*/vim/*.rc.vim source $MYVIMRC |
                    \if has('gui_running') | source $MYGVIMRC
    endif
augroup END

" アクティブウィンドウを目立たせる
augroup vimrcEmphasizeWindow
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinLeave * set nocul
augroup END

