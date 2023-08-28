" Dvorak layout
" d -> h -> j -> f -> t -> k -> d
" l <--> n
" Basic Movement
noremap d h
noremap h gj
noremap t gk
noremap n l
" gd is reserved for coc
noremap gh j
noremap gt k
noremap gn gl
noremap D H
noremap H J
noremap T K
noremap N L
" noremap gj gF
" noremap gJ gf
" noremap gf gt
" noremap gF gT
" delete
noremap k d
noremap kk dd
vunmap kk
noremap K D
noremap c "_c

" jump
" noremap j f
" noremap J F
" noremap f t
" noremap F T
noremap l n
noremap L N
" window movement
noremap <C-w>d <C-w>h
noremap <C-w>h <C-w>j
noremap <C-w>t <C-w>k
noremap <C-w>n <C-w>l

" convienient mapping
" noremap 0 ^
" noremap ^ 0
noremap _ $
" nnoremap e w
" vnoremap e w
" snoremap e w
" nnoremap w e
" vnoremap w e
" snoremap w e
noremap <A-k> "f0D
" noremap <M-k> "f0D

