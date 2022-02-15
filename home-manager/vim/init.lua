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
setmap(
	"n",
	"<C-p>",
	'<cmd>lua require"telescope".extensions.command_palette.command_palette({})<CR>',
	{ silent = true, noremap = true }
)

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
require("nordic").colorscheme({
	underline_option = "none",
	italic = true,
	italic_comments = false,
	minimal_mode = false,
	alternate_backgrounds = false,
})

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

require("treesitter-context").setup({
	enable = true,
	throttle = true,
})

local telescope = require("telescope")
telescope.setup({
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
telescope.load_extension("ghq")
telescope.load_extension("command_palette")
telescope.load_extension("fzf")

require("octo").setup()

require("lualine").setup({ options = { theme = "nord" } })

-- Completion
local cmp = require("cmp")
cmp.setup({
	mapping = {
		["<Tab>"] = cmp.mapping.select_next_item(),
		["<S-Tab>"] = cmp.mapping.select_prev_item(),
		["<CR>"] = cmp.mapping.confirm({ select = true }),
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
	}),
})

-- LSP
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require("lspconfig")
lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.rust_analyzer.setup({ capabilities = capabilities })
lspconfig.rnix.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.dartls.setup({ capabilities = capabilities })
lspconfig.solargraph.setup({ capabilities = capabilities })
lspconfig.terraformls.setup({ capabilities = capabilities })
lspconfig.tsserver.setup({ capabilities = capabilities })
lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim" },
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
		},
	},
	capabilities = capabilities,
})

require("lspsaga").setup({
	error_sign = "!!",
	warn_sign = "!",
	hint_sign = "?",
	infor_sign = ">",
})

require("format").setup({
	go = { { cmd = { "gofmt -w" }, tempfile_postfix = ".tmp" } },
	lua = { { cmd = { "stylua" } } },
	nix = { { cmd = { "nixpkgs-fmt" } } },
})

cmd("augroup Format")
cmd("autocmd!")
cmd("autocmd BufWritePost * FormatWrite")
cmd("augroup END")

local wk = require("which-key")
wk.setup({
	window = {
		border = "double",
	},
})
wk.register({})
