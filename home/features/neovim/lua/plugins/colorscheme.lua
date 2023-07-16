return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			integrations = {
				cmp = true,
				telescope = true,
				gitsigns = true,
				notify = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
				neotest = true,
				noice = true,
				mini = true,
				indent_blankline = { enabled = true },
				navic = { enabled = true },
				lsp_trouble = true,
				overseer = true,
				native_lsp = {
					enabled = true,
					virtual_text = {
						errors = { "italic" },
						hints = { "italic" },
						warnings = { "italic" },
						information = { "italic" },
					},
					underlines = {
						errors = { "underline" },
						hints = { "underline" },
						warnings = { "underline" },
						information = { "underline" },
					},
					inlay_hints = {
						background = true,
					},
				},
			},
		})

		require("catppuccin").load()
	end,
}
