local g = vim.g
local opt = vim.opt

g.mapleader = " "
g.maplocalreader = " "

opt.encoding = "UTF-8"

opt.laststatus = 3 -- global ustatusline
opt.showmode = false

opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indent
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Nubmers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append("sI")

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append("<>[]hl")

opt.termguicolors = true
opt.background = "dark"

opt.swapfile = false
opt.visualbell = true
opt.hlsearch = true
opt.signcolumn = "yes"
opt.completeopt = "menu,menuone,noselect"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.inccommand = "nosplit"
opt.pumblend = 10
opt.timeoutlen = 0
opt.wildmode = "longest:full,full"
opt.cmdheight = 0

opt.splitbelow = true
opt.splitright = true
