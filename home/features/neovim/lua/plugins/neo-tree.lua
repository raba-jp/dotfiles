local M = {}

M.config = function()
	vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
	vim.fn.sign_define("DiagnosticSignError",
		{ text = " ", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn",
		{ text = " ", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo",
		{ text = " ", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint",
		{ text = "", texthl = "DiagnosticSignHint" })

	require("neo-tree").setup({
		close_if_last_window = false,
		popup_border_style = "rounded",
		enable_git_status = true,
		enable_diagnostics = true,
		sort_case_insensitive = false,
		window = {
			position = "float",
		},
		use_libuv_file_watcher = true,
		follow_current_file = true,
	})
end

return M
