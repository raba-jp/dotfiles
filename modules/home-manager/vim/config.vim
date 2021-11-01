set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8


set clipboard&
if has('mac')
  set clipboard+=unnamed
endif
if has('unix')
  set clipboard+=unnamedplus
endif

nnoremap <silent> <ESC><ESC> :nohlsearch<CR>
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

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? "\<C-y>" : "\<cr>"

let g:mapleader = "\<Space>"

set noswapfile
set smartindent
set visualbell
set hlsearch
set backspace=2
set signcolumn=yes
set ignorecase
set smartcase

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

"" Lightline.vim
set laststatus=2
set noshowmode
let g:lightline = { 'colorscheme': 'solarized' }

"" edgemotion
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

"" solarized8
set termguicolors
set background=dark
colorscheme solarized8

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
