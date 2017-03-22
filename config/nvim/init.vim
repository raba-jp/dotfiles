let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:rcfile = s:config_home . '/vim/vimrc'
execute 'source' s:rcfile

""""""""""""""""""""""""""""""
" Python
""""""""""""""""""""""""""""""
let g:python_host_prog = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'

""""""""""""""""""""""""""""""
" Interactive replace
""""""""""""""""""""""""""""""
set inccommand=split
set hlsearch
