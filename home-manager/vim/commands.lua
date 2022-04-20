require("telescope").load_extension("command_center")

local cc = require("command_center")

cc.add({
	{
		description = "Find file",
		cmd = "<CMD>Telescope git_files<CR>",
	},
	{
		description = "List buffers",
		cmd = "<CMD>Telescope buffers<CR>",
	},
	{
		description = "Search inside current buffer",
		cmd = "<CMD>Telescope current_buffer_fuzzy_find<CR>",
	},
	{
		description = "List references",
		cmd = "<CMD>Telescope lsp_references<CR>",
	},
	{
		description = "List document symbols",
		cmd = "<CMD>Telescope lsp_document_symbols<CR>",
	},
	{
		description = "List document diagnostics<CR>",
		cmd = "<CMD>Telescope lsp_document_diagnostics<CR>",
	},
	{
		description = "List workspace symbols",
		cmd = "<CMD>Telescope lsp_workspace_symbols<CR>",
	},
	{
		description = "Workspace Diagnostics",
		cmd = "<CMD>Telescope lsp_document_diagnostics<CR>",
	},
	{
		description = "List definitions",
		cmd = "<CMD>Telescope lsp_definitions<CR>",
	},
	{
		description = "Show command center",
		cmd = "<CMD>Telescope command_center<CR>",
	},
})
