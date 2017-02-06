set encoding=utf-8
scriptencoding utf-8

let g:mapleader = "\<Space>"

""""" Dein.vim Settings """""
let s:vim_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:vimrc = s:vim_home . 'nvim/init.vim'
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/nvim/dein'
let s:dein_repo_dir = s:dein_dir . 'repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' shellescape(s:dein_repo_dir)
endif

let &runtimepath = s:dein_repo_dir .",". &runtimepath

let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
let s:filetype_file = fnamemodify(expand('<sfile>'), ':h').'/filetype.toml'
let s:lazy_toml_file = fnamemodify(expand('<sfile>'), ':h').'/lazy_dein.toml'

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [s:vimrc, s:toml_file, s:filetype_file, s:lazy_toml_file])
  call dein#load_toml(s:toml_file, {'lazy': 0})
  call dein#load_toml(s:filetype_file, {'lazy': 0})
  call dein#load_toml(s:lazy_toml_file, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
"""""""""""""""""""""""""""""

""""" Common """""
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
set sh=zsh
syntax on
let g:python3_host_prog = expand('$PYENV_ROOT') . '/shims/python3.6'
""""""""""""""""""

""""" Mapping ""'""
inoremap <silent> jj <ESC>
nnoremap Y y$
nnoremap + <C-a>
nnoremap - <C-x>
nnoremap <ESC><ESC> :nohlsearch<CR>

""危険なキーマップの無効化
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
nnoremap Q <Nop>
"""""""""""""""""""

""""" File Type Settings """""
augroup FileTypeFormat
  autocmd!
  autocmd BufNewFile,BufRead *.sh setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.rb setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.erb setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.json setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.js setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd BufNewFile,BufRead *.yaml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.yml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.toml set filetype=toml
  autocmd BufNewFile,BufRead *.toml setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.zsh setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead Dockerfile setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
augroup END
""""""""""""""""""""""""""""""

""""" Golang """""
augroup Golang
  autocmd!
  autocmd FileType go :highlight goErr cterm=bold ctermfg=214
  autocmd FileType go :match goErr /\<err\>/
augroup END
""""""""""""""""""

""""" AlpacaTags """""
augroup AlpacaTags
  autocmd!
  if exists(':Tags')
    autocmd BufWritePost Gemfile TagsBundle
    autocmd BufEnter * TagsSet
    autocmd BufWriterPost * TagsUpdate
  endif
augroup END
""""""""""""""""""""""
