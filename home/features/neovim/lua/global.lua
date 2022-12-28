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

require("nvim-treesitter.configs").setup({
	sync_install = false,
	highlight = { enable = true },
	indent = { enable = true },
	lsp_interop = { enable = true },
	refactor = {
		navigation = { enable = true },
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = true },
	},
	rainbow = { enable = true },
})
