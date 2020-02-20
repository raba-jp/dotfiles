set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

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

let g:mapleader = "\<Space>"

nnoremap <silent> <ESC><ESC> :nohlsearch<CR>

set noswapfile
set smartindent
set visualbell
set smartcase
set hlsearch
set backspace=2

filetype plugin indent on
syntax enable

"" 不要なデフォルトプラグインを無効化
let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_2html_plugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
