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
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})
cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-- LSP
require("lsp-format").setup({})

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require("lspconfig")

local default_lsp_options = { capabilities = capabilities, on_attach = require("lsp-format").on_attach }

lspconfig.gopls.setup(default_lsp_options)
lspconfig.rust_analyzer.setup(default_lsp_options)
lspconfig.rnix.setup(default_lsp_options)
lspconfig.pyright.setup(default_lsp_options)
lspconfig.dartls.setup(default_lsp_options)
lspconfig.solargraph.setup(default_lsp_options)
lspconfig.terraformls.setup(default_lsp_options)
lspconfig.tsserver.setup(default_lsp_options)
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
lspconfig.efm.setup({
	on_attach = require("lsp-format").on_attach,
	init_options = { documentFormatting = true },
	filetypes = { "lua" },
	settings = {
		languages = {
			lua = {
				{
					formatCommand = [[stylua -]],
					formatStdin = true,
				},
			},
		},
	},
})

require("lspsaga").setup({
	error_sign = "!!",
	warn_sign = "!",
	hint_sign = "?",
	infor_sign = ">",
})

cmd("augroup Format")
cmd("autocmd!")
cmd("autocmd BufWritePost * Format")
cmd("augroup END")
