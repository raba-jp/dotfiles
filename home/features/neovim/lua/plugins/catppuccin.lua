local M = {}

M.config = function()
	require("catppuccin").setup({
		integrations = {
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
			},
		},
	})

	vim.cmd.colorscheme("catppuccin-mocha")
end

return M
