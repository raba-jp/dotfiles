require("dressing").setup({
	input = {
		enable = true,
	},
	select = {
		enable = true,
		backend = { "telescope", "builtin" },
	},
})

local noremap = { noremap = true }
local noremapSilent = { noremap = true, silent = true }

local legendary = require("legendary")
legendary.setup({
	keymaps = {
		{
			"<leader><space>",
			":Lspsaga hover_doc<CR>",
			description = "Show API document",
			mode = { "n" },
			opts = noremap,
		},
		{
			"<leader>a",
			":Lspsaga code_action<CR>",
			description = "Run code action",
			mode = { "n" },
			opts = noremap,
		},
		{
			"<leader>p",
			":Legendary commands<CR>",
			description = "Show command palette",
			mode = { "n" },
			opts = noremap,
		},
	},
	commands = {
		{
			":Telescope git_files",
			description = "Find file",
		},
		{
			":Telescope buffers",
			description = "List buffers",
		},
		{
			":Telescope current_buffer_fuzzy_find",
			description = "Search inside current buffer",
		},
		{
			":Telescope lsp_references",
			description = "List references",
		},
		{
			":Telescope lsp_document_symbols",
			description = "List document symbols",
		},
		{
			":Telescope lsp_document_diagnostics",
			description = "List document diagnostics",
		},
		{
			":Telescope lsp_workspace_symbols",
			description = "List workspace symbols",
		},
		{
			":Telescope lsp_document_diagnostics",
			description = "Workspace Diagnostics",
		},
		{
			":Telescope lsp_definitions",
			description = "List definitions",
		},
	},
})
