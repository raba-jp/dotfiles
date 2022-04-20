local wk = require("which-key")

wk.setup({
	window = {
		border = "double",
	},
})
wk.register({
	["<space>"] = { "<cmd>Lspsaga hover_doc<cr>", "Show API document" },
	["p"] = { "<CMD>Telescope command_center<CR>", "Show command center" },
	["a"] = { "<CMD>Lspsaga code_action<CR>", "Show code actions" },
}, { prefix = "<leader>" })
