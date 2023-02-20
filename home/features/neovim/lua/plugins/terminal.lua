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
				"<leader>tf",
				"<cmd>ToggleTerm direction=float<CR>",
				desc = "Toggle terminal (float)",
			},
		},
	},
	{
		"chomosuke/term-edit.nvim",
		ft = "toggleterm",
		version = "1.*",
	},
}
