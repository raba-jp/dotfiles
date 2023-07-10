return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdateSync" },
		dependencies = {},
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			context_commentstring = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
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
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
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
