require("impatient")

local function disable_default_plugins()
	vim.g.did_install_default_menus = false
	vim.g.did_install_syntax_menu = false
	vim.g.loaded_2html_plugin = false
	vim.g.loaded_gzip = false
	vim.g.loaded_man = false
	vim.g.loaded_matchit = false
	vim.g.loaded_matchparen = false
	vim.g.loaded_netrwPlugin = false
	vim.g.loaded_remote_plugins = false
	vim.g.loaded_shada_plugin = false
	vim.g.loaded_spellfile_plugin = false
	vim.g.loaded_tarPlugin = false
	vim.g.loaded_tutor_mode_plugin = false
	vim.g.loaded_zipPlugin = false
	vim.g.skip_loading_mswin = false
end

local function global_options()
	vim.g.mapleader = " "
	vim.o.encoding = "UTF-8"
	vim.o.swapfile = false
	vim.o.smartindent = true
	vim.o.smarttab = true
	vim.o.visualbell = true
	vim.o.hlsearch = true
	vim.o.signcolumn = "yes"
	vim.o.smartcase = true
	vim.o.ignorecase = true
	vim.o.showmode = true
	vim.o.completeopt = "menuone,noinsert,noselect"
	vim.o.termguicolors = true
	vim.o.background = "dark"

	if vim.fn.has("mac") then
		vim.o.clipboard = "unnamedplus"
	end
	if vim.fn.has("unix") == 1 then
		vim.o.clipboard = "unnamed"
	end

	vim.api.nvim_set_keymap("i", "jj", "<ESC>", { silent = true })
	vim.api.nvim_set_keymap("n", " ", "<Nop>", { noremap = true })
	vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
	vim.api.nvim_set_keymap("n", ":", ";", { noremap = true })
	vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
	vim.api.nvim_set_keymap("n", "<Tab>", "$", { noremap = true })
	vim.api.nvim_set_keymap("n", "<S-Tab>", "0", { noremap = true })
	vim.api.nvim_set_keymap("n", "ZZ", "<Nop>", { noremap = true })
	vim.api.nvim_set_keymap("n", "ZQ", "<Nop>", { noremap = true })
	vim.api.nvim_set_keymap("n", "Q", "<Nop>", { noremap = true })
	vim.api.nvim_set_keymap("n", "s", "<Nop>", { noremap = true })
	vim.api.nvim_set_keymap("", "<C-j>", "<Plug>(edgemotion-j)", {})
	vim.api.nvim_set_keymap("", "<C-k>", "<Plug>(edgemotion-k)", {})
	vim.api.nvim_set_keymap("n", "<ESC><ESC>", ":nohlsearch<CR>", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { noremap = true, expr = true })
	vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { noremap = true, expr = true })
end

local function colorscheme()
	require("nightfox").setup({
		modules = {
			["cmp"] = true,
			["gitsigns"] = true,
			["lsp_saga"] = true,
			["native_lsp"] = true,
			["notify"] = true,
			["telescope"] = true,
			["treesitter"] = true,
		},
	})
	vim.cmd("colorscheme nordfox")
end

local function lsp()
	local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
	local lspconfig = require("lspconfig")
	local lspformat = require("lsp-format")

	local default_lsp_options = { capabilities = capabilities, on_attach = lspformat.on_attach }

	lspconfig.gopls.setup(default_lsp_options)
	lspconfig.rust_analyzer.setup(default_lsp_options)
	lspconfig.rnix.setup({
		capabilities = capabilities,
		on_attach = function(client)
			client.resolved_capabilities.document_formatting = false
			lspformat.on_attach(client)
		end,
	})
	lspconfig.pyright.setup(default_lsp_options)
	lspconfig.dartls.setup(default_lsp_options)
	lspconfig.solargraph.setup(default_lsp_options)
	lspconfig.terraformls.setup(default_lsp_options)
	lspconfig.tsserver.setup(default_lsp_options)
	lspconfig.yamlls.setup({
		capabilities = capabilities,
		on_attach = lspformat.on_attach,
		settings = {
			yaml = {
				schemaStore = {
					enable = true,
				},
			},
		},
	})
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
	local nullls = require("null-ls")
	nullls.setup({
		on_attach = lspformat.on_attach,
		sources = {
			-- Lua
			nullls.builtins.formatting.stylua,
			nullls.builtins.diagnostics.luacheck,
			-- Nix
			nullls.builtins.formatting.alejandra,
			nullls.builtins.code_actions.statix,
			nullls.builtins.diagnostics.deadnix,
			-- Python
			nullls.builtins.formatting.black,
			-- Protobuf
			nullls.builtins.formatting.buf,
			nullls.builtins.diagnostics.buf,
			nullls.builtins.diagnostics.protolint,
			-- Bazel
			nullls.builtins.formatting.buildifier,
			nullls.builtins.diagnostics.buildifier,
			-- Cue
			nullls.builtins.formatting.cue_fmt,
			nullls.builtins.diagnostics.cue_fmt,
			-- Shell script
			nullls.builtins.formatting.shfmt,
			nullls.builtins.code_actions.shellcheck,
			-- Git
			nullls.builtins.code_actions.gitsigns,
			-- GitHub Actions
			nullls.builtins.diagnostics.actionlint,
			-- Make
			nullls.builtins.diagnostics.checkmake,
			-- Fish
			nullls.builtins.diagnostics.fish,
			-- Dockerfile
			nullls.builtins.diagnostics.hadolint,
		},
	})

	require("lspsaga").setup({})
end

local function treesitter()
	require("nvim-treesitter.configs").setup({
		sync_install = false,
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
	require("treesitter-context").setup({ enable = true, throttle = true })

	local gps = require("nvim-gps")
	gps.setup({
		["class-name"] = " ",
		["function-name"] = " ",
		["method-name"] = " ",
		["container-name"] = "⛶ ",
		["tag-name"] = "炙",
	})

	local colors = {
		nord0 = "#2E3440",
		nord1 = "#3B4252",
		nord2 = "#434C5E",
		nord3 = "#4C566A",
		nord5 = "#E5E9F0",
		nord6 = "#ECEFF4",
		nord7 = "#8FBCBB",
		nord8 = "#88C0D0",
		nord13 = "#EBCB8B",
	}
	local lualine_theme = {
		normal = {
			a = { fg = colors.nord1, bg = colors.nord8, gui = "bold" },
			b = { fg = colors.nord5, bg = colors.nord2 },
			c = { fg = colors.nord5, bg = colors.nord0 },
		},
		insert = { a = { fg = colors.nord1, bg = colors.nord6, gui = "bold" } },
		visual = { a = { fg = colors.nord1, bg = colors.nord7, gui = "bold" } },
		replace = { a = { fg = colors.nord1, bg = colors.nord13, gui = "bold" } },
		inactive = {
			a = { fg = colors.nord1, bg = colors.nord8, gui = "bold" },
			b = { fg = colors.nord5, bg = colors.nord1 },
			c = { fg = colors.nord5, bg = colors.nord1 },
		},
	}

	require("lualine").setup({
		options = {
			theme = lualine_theme,
			component_separators = "|",
			section_separators = { left = "", right = "" },
		},
		sections = {
			lualine_a = {
				{ "mode", separator = { left = "" }, right_padding = 2 },
			},
			lualine_b = {
				{ "filetype", icon_only = true, separator = { right = "" } },
				"filename",
			},
			lualine_c = {
				{ gps.get_location, cond = gps.is_available },
			},
			lualine_x = {
				{
					"lsp_progress",
					display_components = { "lsp_client_name", { "title", "percentage", "message" } },
				},
				{
					"diagnostics",
					sources = { "nvim_diagnostic", "nvim_lsp" },
					section = { "error", "warn", "info", "hint" },
					diagnostics_color = {
						error = "DiagnosticError",
						warn = "DiagnosticWarn",
						info = "DiagnosticInfo",
						hint = "DiagnosticHint",
					},
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
					colored = true,
					update_in_insert = true,
					always_visible = false,
				},
			},
			lualine_y = {
				{ "location", separator = { left = "", right = "" }, left_padding = 2 },
			},
			lualine_z = {},
		},
	})
end

local function telescope()
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
	require("telescope").load_extension("ghq")
	require("telescope").load_extension("fzf")
end

local function commands()
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
end

local function completion()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lspkind = require("lspkind")

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	cmp.setup({
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		mapping = {
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end, { "i", "s", "c" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s", "c" }),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
		},
		sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "nvim_lsp_signature_help" },
			{ name = "luasnip" },
			{ name = "buffer" },
		}),
		formatting = {
			format = lspkind.cmp_format({}),
		},
	})
	cmp.setup.cmdline("/", {
		sources = {
			{ name = "nvim_lsp_document_symbol" },
			{ name = "buffer" },
		},
	})
	cmp.setup.cmdline(":", {
		sources = cmp.config.sources({
			{ name = "cmdline" },
		}),
	})
end

disable_default_plugins()
global_options()
colorscheme()
lsp()
treesitter()
telescope()
commands()
completion()

vim.notify = require("notify")
require("gitsigns").setup()

require("hop").setup()
require("lightspeed").setup({})
