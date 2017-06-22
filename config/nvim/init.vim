set encoding=utf-8
scriptencoding utf-8

""" Leader key mapping
let g:mapleader = "\<Space>"

""" XDG Base Direcotries
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let g:data_home = empty($XDG_DATE_HOME) ? expand('~/.local/share') : $XDG_DATA_HOME

function s:install_dein()
  let l:repo_dir = g:data_home . '/vim/dein/repos/github.com/Shougo/dein.vim'
  let &runtimepath = l:repo_dir .','. &runtimepath

  if !isdirectory(l:repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' shellescape(l:repo_dir)
  endif
endfunction

function s:initialize_dein()
  let l:install_dir = g:data_home . '/vim/dein'
  let l:config_file = g:config_home . '/nvim/init.nvim'
  let l:plugins_file = g:config_home . '/nvim/plugins.toml'
  let l:lazy_load_file = g:config_home . '/nvim/plugins_lazy.toml'

  if dein#load_state(l:install_dir)
    call dein#begin(l:install_dir, [l:config_file, l:plugins_file, l:lazy_load_file])
    call dein#load_toml(l:plugins_file, {'lazy': 0})
    call dein#load_toml(l:lazy_load_file, {'lazy': 1})
    call dein#end()
    call dein#save_state()
  endif

  if dein#check_install()
    call dein#install()
  endif
endfunction

call s:install_dein()
call s:initialize_dein()

set number
set fileencoding=utf-8
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
syntax on
set foldmethod=syntax
set foldlevel=100
set hidden

inoremap <silent> jj <ESC>
nnoremap <ESC><ESC> :nohlsearch<CR>
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>
nnoremap Y y$

""" Disable danger mapping
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>

""" Disable `s` mapping
nnoremap s <Nop>

""" Move window mapping
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l

""" Split window mapping
nnoremap sh :split<CR>
nnoremap sv :vsplit<CR>

""" Change window size mapping
nnoremap s= <C-w>=
nnoremap sL <C-w>>
nnoremap sH <C-w><
nnoremap sJ <C-w>+
nnoremap sK <C-w>-

"""nnoremap H 0
"""nnoremap L $

if has('patch-7.4.1778')
  set guicolors
endif

if has('nvim')
  """ Mapping
  tnoremap <silent> <ESC> <C-\><C-n>

  let g:python_host_prog = '/usr/local/bin/python2.7'
  let g:python3_host_prog = '/usr/local/bin/python3.6'

  set shell=fish
  set inccommand=split
  set hlsearch
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
