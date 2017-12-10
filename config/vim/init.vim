set encoding=utf-8
scriptencoding utf-8
set fileencoding=utf-8

let g:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let g:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let g:data_home = empty($XDG_DATA_HOME) ? expand('~/.local/share') : $XDG_DATA_HOME

runtime! init/mapping.vim
runtime! init/commons.vim
runtime! init/load_plugins.vim
