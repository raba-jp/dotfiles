local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["jj"] = actions.close,
			},
		},
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
	pickers = {
		buffers = {
			mappings = {
				i = {
					["<c-d>"] = actions.delete_buffer + actions.move_to_top,
				},
			},
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})
