vim.g.mapleader = " "
vim.g.maplocalreader = " "

local opt = vim.opt
local fn = vim.fn
if fn.has("mac") == 1 then
	opt.clipboard = "unnamedplus"
end
if fn.has("unix") == 1 then
	opt.clipboard = "unnamed"
end
opt.encoding = "UTF-8"
opt.swapfile = false
opt.smartindent = true
opt.smarttab = true
opt.visualbell = true
opt.hlsearch = true
opt.signcolumn = "yes"
opt.smartcase = true
opt.ignorecase = true
opt.completeopt = "menu,menuone,noselect"
opt.termguicolors = true
opt.background = "dark"
opt.number = true
opt.cursorline = true
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit"
opt.laststatus = 0
opt.mouse = "a"
opt.pumblend = 10
opt.pumheight = 10
opt.splitbelow = true
opt.splitright = true
opt.timeoutlen = 300
opt.wildmode = "longest:full,full"
opt.background = "dark"
opt.cmdheight = 0
