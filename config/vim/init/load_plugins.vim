set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

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
  call dein#load_toml((s:plugins . '/completion.toml'), {})
  call dein#load_toml((s:plugins . '/language_supports.toml'), {})
  call dein#load_toml((s:plugins . '/fuzzy_finder.toml'), {})
  call dein#load_toml((s:plugins . '/utility.toml'), {})
  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif
