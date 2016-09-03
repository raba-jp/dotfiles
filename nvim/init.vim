if &compatible
  set nocompatible
endif

augroup AutoCmd
  autocmd!
augroup END

" dein settings ------------
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CAHCE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' shellescape(s:dein_repo_dir)
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir, ['~/.config/nvim/init.vim', s:toml_file])
  call dein#load_toml(s:toml_file)
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif

" Clipboard settings
set clipboard+=unnamedplus

let g:python3_host_prog = '/usr/local/bin/python3'
