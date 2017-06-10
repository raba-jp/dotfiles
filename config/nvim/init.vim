""" Leader key mapping
let g:mapleader = "\<Space>"

""" Variables
let g:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let g:data_home = empty($XDG_DATE_HOME) ? expand('~/.local/share') : $XDG_DATA_HOME

""" runtimepath
let &runtimepath = g:config_home . '/nvim' .','. &runtimepath

function s:install_dein()
  let repo_dir = g:data_home . '/vim/dein/repos/github.com/Shougo/dein.vim'
  let &runtimepath = repo_dir .','. &runtimepath

  if !isdirectory(repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' shellescape(repo_dir)
  endif
endfunction

function s:initialize_dein()
  let install_dir = g:data_home . '/vim/dein'
  let config_file = g:config_home . '/nvim/init.nvim'
  let plugins_file = g:config_home . '/nvim/plugins.toml'
  let lazy_load_file = g:config_home . '/nvim/plugins_lazy.toml'

  if dein#load_state(install_dir)
    call dein#begin(install_dir, [config_file, plugins_file, lazy_load_file])
    call dein#load_toml(plugins_file, {'lazy': 0})
    call dein#load_toml(lazy_load_file, {'lazy': 1})
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
syntax on
set foldmethod=syntax
set foldlevel=100
set hidden

inoremap <silent> jj <ESC>
nnoremap <silent> <Leader><Leader> za

nnoremap Y y$
nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
map <Up> <Nop>
map <Down> <Nop>
map <Left> <Nop>
map <Right> <Nop>
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

nnoremap H 0
nnoremap L $

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
