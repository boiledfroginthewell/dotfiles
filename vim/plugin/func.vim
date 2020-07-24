" create directory automatically when open a file
augroup vimrc-auto-mkdir
    autocmd!
    autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
    function! s:auto_mkdir(dir, force)
        if !isdirectory(a:dir) && (a:force ||
            \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
            call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
        endif
    endfunction
augroup END

" Reload .vimrc/.gvimrc after saving .vimrc
augroup MyAutoCmd
    autocmd!

    if !has('gui_running') && !(has('win32') || has('win64'))
        " .vimrcの再読込時にも色が変化するようにする
        autocmd MyAutoCmd BufWritePost vimrc,vundle.vim,*/vim/plugin/*.vim,*/vim/*.rc.vim nested source $MYVIMRC
    else
        " .vimrcの再読込時にも色が変化するようにする
        autocmd MyAutoCmd BufWritePost vimrc,vundle.vim,*/vim/plugin/*.vim,*/vim/*.rc.vim source $MYVIMRC |
                    \if has('gui_running') | source $MYGVIMRC
        autocmd MyAutoCmd BufWritePost vimrc,vundle.vim if has('gui_running') | source $MYGVIMRC
    endif
augroup END

" アクティブウィンドウを目立たせる
augroup vimrcEmphasizeWindow
	autocmd!
	autocmd WinEnter * set cul
	autocmd WinLeave * set nocul
augroup END

