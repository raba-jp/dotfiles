set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

let g:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let g:data_home = empty($XDG_DATA_HOME) ? expand('~/.local/share') : $XDG_DATA_HOME

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
    let g:python3_host_prog = '/usr/local/bin/python3.7'
  elseif has('unix')
    " TODO
  endif
endif

let s:plugins = g:config_home . '/vim/plugins'
let s:dein_dir = g:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#add('Shougo/dein.vim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#load_toml((s:plugins . '/colorscheme.toml'), {})
  call dein#load_toml((s:plugins . '/statusline.toml'), {})
  call dein#load_toml((s:plugins . '/language_supports.toml'), {})
  call dein#load_toml((s:plugins . '/fuzzy_finder.toml'), {})
  call dein#load_toml((s:plugins . '/utility.toml'), {})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

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
vnoremap x "_x
nnoremap X "_X
vnoremap X "_X
vnoremap p "_dP

