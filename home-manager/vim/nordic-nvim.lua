vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

require("nordic").colorscheme({
	underline_option = "none",
	italic = true,
	italic_comments = false,
	minimal_mode = false,
	alternate_backgrounds = false,
})
