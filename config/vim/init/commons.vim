set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

if has('nvim')
  set clipboard+=unnamedplus
else
  set clipboard+=unnamed
endif

set noswapfile
set showcmd
set noshowmode
set smartindent
set visualbell
set listchars=tab:»-,trail:-,nbsp:%,eol:↲
set showmatch
set smartcase
set incsearch
set hlsearch
set matchtime=1
set wrapscan
set nowrap
set foldmethod=syntax
set foldlevel=100
set hidden
set ambiwidth=double
set nocursorline
set laststatus=2
set list
set backspace=2
set wildmode=longest,full
filetype plugin indent on

if has('nvim')
  set inccommand=split
  set shell=fish
  set ttimeout
  set ttimeoutlen=100

  " TrueColor
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " Terminal
  tnoremap <silent> <ESC> <C-\><C-n>
  tnoremap <silent> <C-j> <C-\><C-n>

  " Python
  if has('mac')
    let g:python_host_prog = '/usr/local/bin/python2.7'
    let g:python3_host_prog = '/usr/local/bin/python3.6'
  elseif has('unix')
    " TODO
  endif
endif

autocmd FileType *.py syntax keyword Special self
" fallback
" autocmd VimEnter,WinEnter *.py syntax keyword Special self
