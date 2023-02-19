return {
	"nvim-treesitter/nvim-treesitter",
	version = false,
	build = ":TSUpdate",
	event = "BufReadPost",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require("treesitter-context").setup({
				enable = true,
			})
		end,
	},
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
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
