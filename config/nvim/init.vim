let g:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME

let g:nvim_plugins_home = g:config_home . '/nvim/plugins'

let s:rcfile = g:config_home . '/vim/vimrc'
execute 'source' s:rcfile

""" NeoVim only key mapping
let s:nvim_mapping = g:config_home . '/nvim/mapping.nvim'
execute 'source' s:nvim_mapping

if has('nvim')
  let g:python_host_prog = '/usr/local/bin/python2.7'
  let g:python3_host_prog = '/usr/local/bin/python3.6'

  set shell=fish
  set inccommand=split
  set hlsearch
endif
