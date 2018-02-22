set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

let g:mapleader = "\<Space>"

" Disable search highlight
nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

" Change normal mode
inoremap <silent> jj <ESC>

" for US kyeboard
nnoremap ; :
nnoremap : ;

" Disable Cursor key
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

" Yank line tail
nnoremap Y y$

" Disable danger mapping
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

" Disable 's' key
nnoremap s <Nop>

" Move window mapping
nnoremap sk <C-w>k
nnoremap sj <C-w>j
nnoremap sh <C-w>h
nnoremap sl <C-w>l

" Split window mapping
nnoremap ss :split<CR>
nnoremap sv :vsplit<CR>

" Change window size mapping
nnoremap s= <C-w>=
nnoremap sK <C-w>-
nnoremap sJ <C-w>+
nnoremap sL <C-w>>
nnoremap sH <C-w><

" Create new tab
nnoremap st :tabnew<CR>

" Move tab
nnoremap sn gt
nnoremap sp gT

nnoremap <TAB> $
nnoremap <S-TAB> 0

nnoremap x "_x
