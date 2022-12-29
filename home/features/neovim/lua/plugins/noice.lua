local M = {}

M.init = function()
	vim.opt.cmdheight = 0
end

M.config = function()
	require("noice").setup({
		views = {
			cmdline_popup = {
				position = {
					row = "40%",
					col = "50%",
				},
				size = {
					width = 60,
					height = "auto",
				},
				border = {
					style = "none",
					padding = { 2, 3 },
				},
				filter_options = {},
				win_options = {
					winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
				},
			},
			popupmenu = {
				relative = "editor",
				position = {
					row = 8,
					col = "50%",
				},
				size = {
					width = 60,
					height = 10,
				},
				win_options = {
					winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
				},
			},
		},
	})
end

return M
