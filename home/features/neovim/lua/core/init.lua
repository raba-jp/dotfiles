vim.g.did_install_default_menus = 1
vim.g.did_install_syntax_menu = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_man = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_remote_plugins = 1
vim.g.loaded_shada_plugin = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.skip_loading_mswin = 1

-- vim.opt.inccommand = "split"

vim.api.nvim_set_keymap("i", "jj", "<ESC>", { silent = true })

if vim.fn.has("mac") then
	vim.opt.clipboard = "unnamedplus"
end
if vim.fn.has("unix") == 1 then
	vim.opt.clipboard = "unnamed"
end
vim.g.mapleader = " "
vim.opt.encoding = "UTF-8"
vim.opt.swapfile = false
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.visualbell = true
vim.opt.hlsearch = true
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.termguicolors = true
vim.opt.background = "dark"
