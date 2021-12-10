local fn = vim.fn
local cmd = vim.cmd
local opt = vim.o
local gvar = vim.g
local setmap = vim.api.nvim_set_keymap

-- Keybindings
setmap("n", " ", "<Nop>", { noremap = true })
setmap("i", "jj", "<ESC>", { silent = true })
setmap("n", ";", ":", { noremap = true })
setmap("n", ":", ";", { noremap = true })
setmap("n", "Y", "y$", { noremap = true })
setmap("n", "<Tab>", "$", { noremap = true })
setmap("n", "<S-Tab>", "0", { noremap = true })
setmap("n", "ZZ", "<Nop>", { noremap = true })
setmap("n", "ZQ", "<Nop>", { noremap = true })
setmap("n", "Q", "<Nop>", { noremap = true })
setmap("n", "s", "<Nop>", { noremap = true })
setmap("", "<C-j>", "<Plug>(edgemotion-j)", {})
setmap("", "<C-k>", "<Plug>(edgemotion-k)", {})
setmap("n", "<ESC><ESC>", ":nohlsearch<CR>", { noremap = true, silent = true })
setmap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { noremap = true, expr = true })
setmap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { noremap = true, expr = true })

setmap("n", "sh", '<cmd>lua require"lspsaga.provider".lsp_finder()<CR>', { silent = true, noremap = true })
setmap("n", "sa", '<cmd>lua require"lspsaga.codeaction".code_action()<CR>', { silent = true, noremap = true })
setmap("v", "sa", ':<C-U>lua require"lspsaga.codeaction".range_code_action()<CR>', { silent = true, noremap = true })
setmap("n", "sk", '<cmd>lua require"lspsaga.hover".render_hover_doc()<CR>', { silent = true, noremap = true })
setmap(
	"n",
	"<C-f>",
	'<cmd>lua require"lspsaga.action".smart_scroll_with_saga(1)<CR>',
	{ silent = true, noremap = true }
)
setmap(
	"n",
	"<C-b>",
	'<cmd>lua require"lspsaga.action".smart_scroll_with_saga(-1)<CR>',
	{ silent = true, noremap = true }
)

gvar.mapleader = " "

-- Config
if fn.has("mac") then
	opt.clipboard = "unnamedplus"
end
if fn.has("unix") == 1 then
	opt.clipboard = "unnamed"
end
opt.encoding = "UTF-8"
opt.swapfile = false
opt.smartindent = true
opt.smarttab = true
opt.visualbell = true
opt.hlsearch = true
opt.signcolumn = "yes"
opt.smartcase = true
opt.ignorecase = true
opt.showmode = true
opt.completeopt = "menuone,noinsert,noselect"
opt.termguicolors = true
opt.background = "dark"

cmd("syntax on")
cmd("filetype plugin indent on")
cmd("colorscheme nord")

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"nix",
		"rust",
		"lua",
		"dart",
		"python",
		"typescript",
		"fish",
		"bash",
		"go",
		"yaml",
		"json",
		"graphql",
		"dockerfile",
	},
	highlight = { enable = true },
	indent = { enable = true },
	lsp_interop = { enable = true },
	refactor = {
		navigation = { enable = true },
		highlight_definitions = { enable = true },
		highlight_current_scope = { enable = true },
	},
	rainbow = { enable = true },
})

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
		},
		prompt_prefix = "> ",
		selection_caret = "> ",
		entry_prefix = " ",
		set_env = { ["COLORTERM"] = "truecolor" },
	},
})

require("lualine").setup({ options = { theme = "nord" } })

-- LSP
local lspconfig = require("lspconfig")
lspconfig.gopls.setup({})
lspconfig.rust_analyzer.setup({})

-- Completion
require("compe").setup({
	enabled = true,
	autocomplete = true,
	debug = false,
	min_length = 1,
	preselect = "enable",

	source = { buffer = true, nvim_lsp = true },
})

require("lspsaga").init_lsp_saga()

require("format").setup({
	go = { { cmd = { "gofmt -w" }, tempfile_postfix = ".tmp" } },
	nix = { { cmd = { "nixfmt" } } },
})

cmd("augroup Format")
cmd("autocmd!")
cmd("autocmd BufWritePost * FormatWrite")
cmd("augroup END")
