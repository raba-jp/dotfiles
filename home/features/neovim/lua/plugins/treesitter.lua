return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = "VeryLazy",
	dependencies = {},
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		context_commentstring = {
			enable = true,
		},
		ensure_installed = {
			"bash",
			"html",
			"javascript",
			"typescript",
			"lua",
			"json",
			"terraform",
			"go",
			"rust",
			"tsx",
			"vim",
			"yaml",
			"toml",
			"zig",
			"nix",
			"regex",
			"markdown",
			"markdown_inline",
		},
		incremental_selection = {
			enable = true,
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
	keys = {
		{
			"<leader>ss",
			function()
				require("nvim-treesitter.incremental_selection").init_selection()
			end,
			desc = "Start incremental selection",
		},
		{
			"<leader>si",
			function()
				require("nvim-treesitter.incremental_selection").node_incremental()
			end,
			desc = "Incremental selection for node",
		},
		{
			"<leader>sc",
			function()
				require("nvim-treesitter.incremental_selection").scope_incremental()
			end,
			desc = "Incremental selection for scope",
		},
		{
			"<leader>sd",
			function()
				require("nvim-treesitter.incremental_selection").node_decremental()
			end,
			desc = "Decremental selection for node",
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		name = "treesitter-context",
		event = "VeryLazy",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			enable = true,
		},
	},
}
