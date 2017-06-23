set encoding=utf-8
scriptencoding utf-8

""" Leader key mapping
let g:mapleader = "\<Space>"

""" XDG Base Direcotries
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let g:data_home = empty($XDG_DATE_HOME) ? expand('~/.local/share') : $XDG_DATA_HOME

" Install dein.vim
let s:dein_dir = g:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" Load plugins
if dein#load_state(s:dein_dir)
  let s:visual = g:config_home . '/nvim/visual.toml'
  let s:syntax_highlight = g:config_home . '/nvim/syntax_highlight.toml'
  let s:statusline = g:config_home . '/nvim/statusline.toml'
  let s:search = g:config_home . '/nvim/search.toml'
  let s:language = g:config_home . '/nvim/language.toml'
  let s:fuzzy_finder = g:config_home . '/nvim/fuzzy_finder.toml'
  let s:auto_complete = g:config_home . '/nvim/auto_complete.toml'

  let s:plugins_file = g:config_home . '/nvim/plugins.toml'

  call dein#begin(s:dein_dir)
  call dein#add('Shougo/dein.vim')
  call dein#load_toml(s:visual,           {'lazy': 0})
  call dein#load_toml(s:syntax_highlight, {'lazy': 0})
  call dein#load_toml(s:search,           {'lazy': 0})
  call dein#load_toml(s:fuzzy_finder,     {'lazy': 1})
  call dein#load_toml(s:auto_complete,    {'lazy': 1})

  call dein#load_toml(s:plugins_file, {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif

" Install plugins
if dein#check_install()
  call dein#install()
endif

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
