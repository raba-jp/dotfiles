set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

set clipboard&
set clipboard+=unnamedplus

inoremap <silent> jj <ESC>
nnoremap ; :
nnoremap : ;
nnoremap Y y$
nnoremap <TAB> $
nnoremap <S-TAB> 0
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
nnoremap s <Nop>

set noswapfile
set smartindent
set visualbell
set smartcase
set hlsearch
set backspace=2

filetype plugin indent on
syntax enable
