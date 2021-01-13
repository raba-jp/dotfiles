local fn = vim.fn
local cmd = vim.cmd
local opt = vim.o
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	cmd([[!git clone https://github.com/wbthomason/packer.nvim ]]..install_path)
end

opt.clipboard = 'unnamedplus'
opt.encoding = 'UTF-8'
opt.swapfile = true
opt.smartindent = true
opt.smarttab = true
opt.visualbell = true
opt.hlsearch = true
opt.signcolumn = 'yes'
opt.smartcase = true
opt.ignorecase = true
opt.showmode = true
opt.completeopt = 'menuone,noinsert,noselect'

require 'keybindings'
require 'commands'
require 'ui'

vim.cmd [[augroup lsp_aucmds]]
vim.cmd [[au BufEnter * lua require('completion').on_attach()]]
vim.cmd [[augroup END]]
