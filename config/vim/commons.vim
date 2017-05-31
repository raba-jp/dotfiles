set number
set fenc=utf-8
set noswapfile
set showcmd
set smartindent
set visualbell
set laststatus=2
filetype plugin indent on
set list
set listchars=tab:»-,trail:-,nbsp:%,eol:↲
set relativenumber number
set wildmenu
set clipboard+=unnamedplus
set showmatch
set smartcase
set incsearch
set hlsearch
set matchtime=1
set wrapscan
set nowrap
set sh=zsh
syntax on
set foldmethod=syntax
set foldlevel=100

if has('patch-7.4.1778')
  set guicolors
endif
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
