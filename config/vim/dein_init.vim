""""""""""""""""""""""""""""""
"""  dein.vim initialize   """
""""""""""""""""""""""""""""""
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:vim_config_file = s:config_home . '/vim/vimrc'
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_install_dir = s:cache_home . '/vim/dein'
let s:dein_repo_dir = s:dein_install_dir . 'repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
	execute '!git clone https://github.com/Shougo/dein.vim' shellescape(s:dein_repo_dir)
endif

let &runtimepath = s:dein_repo_dir .','. &runtimepath

""""" Plugins list file """""
let s:plugins_file = s:config_home . '/vim/plugins.toml'
let s:filetype_file = s:config_home . '/vim/filetype.toml'
let s:lazy_load_file = s:config_home . '/vim/plugins_lazy.toml'

if dein#load_state(s:dein_install_dir)
	call dein#begin(s:dein_install_dir,
	\ [s:vim_config_file, s:plugins_file, s:filetype_file, s:lazy_load_file])
	call dein#load_toml(s:plugins_file, {'lazy': 0})
	call dein#load_toml(s:filetype_file, {'lazy': 0})
	call dein#load_toml(s:lazy_load_file, {'lazy': 1})
	call dein#end()
	call dein#save_state()
endif

if dein#check_install()
	call dein#install()
endif
