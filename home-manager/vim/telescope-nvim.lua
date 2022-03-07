require("telescope").setup({
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--ne-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--trim",
		},
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = " ",
		set_env = { ["COLORTERM"] = "truecolor" },
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},

		command_palette = {
			{
				"File",
				{ "Files", ":lua require('telescope.builtin').find_files()", 1 },
				{ "File browser", ":lua require('telescope.builtin').file_browser()", 1 },
				{ "Git files", ":lua require('telescope.builtin').git_files()", 1 },
			},
			{
				"Navigation",
				{ "Buffers", ":lua require('telescope.builtin').buffers()", 1 },
				{ "Search", ":lua require('telescope.builtin').current_buffer_fuzzy_find()", 1 },
			},
			{
				"LSP",
				{ "References", ":lua require('telescope.builtin').lsp_references()", 1 },
				{ "Document Symbols", ":lua require('telescope.builtin').lsp_document_symbols()", 1 },
				{ "Document Diagnostics", ":lua require('telescope.builtin').lsp_document_diagnostics()", 1 },
				{ "Workspace Symbols", ":lua require('telescope.builtin').lsp_workspace_symbols()", 1 },
				{ "Workspace Diagnostics", ":lua require('telescope.builtin').lsp_document_diagnostics", 1 },
				{ "Definitions", ":lua require('telescope.builtin').lsp_definitions()", 1 },
			},
			{
				"Vim",
				{ "Commands", ":lua require('telescope.builtin').commands()", 1 },
				{ "Registers", ":lua require('telescope.builtin').registers()", 1 },
			},
			{ "Help", { "Show cheatsheet", ":Cheatsheet", 1 }, { "Edit cheatsheet", ":CheatsheetEdit", 1 } },
		},
	},
})
