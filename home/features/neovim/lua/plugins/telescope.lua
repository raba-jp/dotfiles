local M = {}

M.config = function()
	local actions = require("telescope.actions")

	require("telescope").setup({
		defaults = {
			mappings = {
				i = {
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
			prompt_prefix = " ",
			selection_caret = " ",
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

	require("telescope").load_extension("ghq")
	require("telescope").load_extension("fzf")
	require("telescope").load_extension("file_browser")
end

return M
