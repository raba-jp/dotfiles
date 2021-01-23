local cmd = vim.cmd
local setopt = vim.o
local setvar = vim.api.nvim_set_var

setopt.background = 'dark'
setopt.termguicolors = true

cmd('syntax on')
cmd('filetype plugin indent on')
cmd('colorscheme solarized8')

setvar('lightline', {colorscheme = 'solarized'})
