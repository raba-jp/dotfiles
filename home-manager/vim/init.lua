-- Disable default plugin
vim.g.did_install_default_menus = false
vim.g.did_install_syntax_menu = false
vim.g.loaded_2html_plugin = false
vim.g.loaded_gzip = false
vim.g.loaded_man = false
vim.g.loaded_matchit = false
vim.g.loaded_matchparen = false
vim.g.loaded_netrwPlugin = false
vim.g.loaded_remote_plugins = false
vim.g.loaded_shada_plugin = false
vim.g.loaded_spellfile_plugin = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_tutor_mode_plugin = false
vim.g.loaded_zipPlugin = false
vim.g.skip_loading_mswin = false

-- Global option
vim.g.mapleader = " "
vim.o.encoding = "UTF-8"
vim.o.swapfile = false
vim.o.smartindent = true
vim.o.smarttab = true
vim.o.visualbell = true
vim.o.hlsearch = true
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.ignorecase = true
vim.o.showmode = true
vim.o.completeopt = "menuone,noinsert,noselect"
vim.o.termguicolors = true
vim.o.background = "dark"

-- Keybindings
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { silent = true })
vim.api.nvim_set_keymap("n", " ", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", ":", ";", { noremap = true })
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
vim.api.nvim_set_keymap("n", "<Tab>", "$", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", "0", { noremap = true })
vim.api.nvim_set_keymap("n", "ZZ", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "ZQ", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "Q", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "s", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("", "<C-j>", "<Plug>(edgemotion-j)", {})
vim.api.nvim_set_keymap("", "<C-k>", "<Plug>(edgemotion-k)", {})
vim.api.nvim_set_keymap("n", "<ESC><ESC>", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { noremap = true, expr = true })

-- Config
if vim.fn.has("mac") then
	vim.o.clipboard = "unnamedplus"
end
if vim.fn.has("unix") == 1 then
	vim.o.clipboard = "unnamed"
end
