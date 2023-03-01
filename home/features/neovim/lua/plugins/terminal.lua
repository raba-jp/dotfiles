return {
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		opts = {
			float_opts = {
				border = "solid",
			},
		},
		keys = {
			{
				"<leader>tt",
				"<cmd>ToggleTerm direction=float<CR>",
				desc = "Toggle terminal",
			},
		},
	},
	{
		"chomosuke/term-edit.nvim",
		ft = "toggleterm",
		version = "1.*",
	},
}
