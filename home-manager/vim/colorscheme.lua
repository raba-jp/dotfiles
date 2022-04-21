vim.cmd("colorscheme nordfox")
require("nightfox").setup({
	modules = {
		["cmp"] = true,
		["gitsigns"] = true,
		["lsp_saga"] = true,
		["native_lsp"] = true,
		["notify"] = true,
		["telescope"] = true,
		["treesitter"] = true,
	},
})
