"""" nocompatible mode """""
if &compatible
  set nocompatible
endif
"""""""""""""""""""""""""""""

""""" XDG Base Direcotry """""
set directory=$XDG_CACHE_HOME/vim,~/,/tmp
set backupdir=$XDG_CACHE_HOME/vim,~/,/tmp
" set viminfo+=n$XDG_CACHE_HOME/vim/viminfo
set viminfo=
set runtimepath=$XDG_CONFIG_HOME/vim,$XDG_CONFIG_HOME/vim/after,$VIM,$VIMRUNTIME
let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
""""""""""""""""""""""""""""""

""""" Dein.vim Settings """""
let s:vim_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:vimrc = s:vim_home . 'vim/vimrc.vim'
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/vim/dein'
let s:dein_repo_dir = s:dein_dir . 'repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' shellescape(s:dein_repo_dir)
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, [s:vimrc, s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
"""""""""""""""""""""""""""""

""""" Common """""
filetype on
syntax on
set number
set noswapfile
set showcmd
set smartindent
set virtualedit=block
set visualbell
set laststatus=2
filetype plugin indent on
set clipboard+=unnamed
set list
set listchars=tab:»-,trail:-,nbsp:%,eol:↲
set relativenumber number
set wildmenu

nnoremap O :<C-u>call append(expand('.'), '')<Cr>j
""""""""""""""""""

""""" File Type Settings """""
augroup FileTypeFormat
  autocmd!
  autocmd BufNewFile,BufRead *.sh setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.rb setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.json setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.js setlocal expandtab tabstop=2 softtabstop=2 shiftwidth=2
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
augroup END
""""""""""""""""""""""""""""""

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
