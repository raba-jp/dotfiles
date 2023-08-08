return {
	{
		"nvim-treesitter/nvim-treesitter",
		version = false,
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSUpdateSync" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		opts = {
			highlight = {
				enable = true,
				use_languagetree = true,
				additional_vim_regex_highlighting = false,
			},
			textobjects = {
				select = {
					enable = true,
				},
			},
			indent = { enable = true },
			context_commentstring = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-s>",
					node_incremental = "<C-s>",
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
