require("impatient").enable_profile()
require("lazy").setup({
	"nvim-lua/plenary.nvim",
	{
		"gpanders/editorconfig.nvim",
		lazy = false,
		priority = 200,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				integrations = {
					native_lsp = {
						enabled = true,
						virtual_text = {
							errors = { "italic" },
							hints = { "italic" },
							warnings = { "italic" },
							information = { "italic" },
						},
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
				},
			})

			vim.cmd.colorscheme("catppuccin-mocha")
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		priority = 900,
		config = function()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
				},
			})
		end,
	},
	"neovim/nvim-lspconfig",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"hrsh7th/cmp-nvim-lsp-signature-help",
	"onsails/lspkind.nvim",
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		priority = 998,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("plugins.lsp")
		end,
	},
	{
		"hrsh7th/cmp-nvim-lsp-signature-help",
		event = "BufEnter",
	},
	"kyazdani42/nvim-web-devicons",
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufEnter",
		config = function()
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
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "BufEnter",
		init = function()
			vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
			vim.api.nvim_create_autocmd("LspAttach", {
				group = "LspAttach_inlayhints",
				callback = function(args)
					if not (args.data and args.data.client_id) then
						return
					end

					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					require("lsp-inlayhints").on_attach(client, bufnr)
				end,
			})
		end,
		config = function()
			require("lsp-inlayhints").setup()
		end,
	},

	{
		"folke/noice.nvim",
		keys = { ":" },
		init = function()
			vim.opt.cmdheight = 0
		end,
		config = function()
			require("noice").setup({
				views = {
					cmdline_popup = {
						position = {
							row = "40%",
							col = "50%",
						},
						size = {
							width = 60,
							height = "auto",
						},
						border = {
							style = "none",
							padding = { 2, 3 },
						},
						filter_options = {},
						win_options = {
							winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
						},
					},
					popupmenu = {
						relative = "editor",
						position = {
							row = 8,
							col = "50%",
						},
						size = {
							width = 60,
							height = 10,
						},
						win_options = {
							winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
						},
					},
				},
			})
		end,
	},
	"MunifTanjim/nui.nvim",
	"rcarriga/nvim-notify",
	{
		"lewis6991/gitsigns.nvim",
		event = "BufEnter",
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		-- TODO
		"numToStr/Comment.nvim",
		keys = { "<leader>c" },
		config = function()
			require("Comment").setup()
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				source = {
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},
	{
		"folke/which-key.nvim",
		lazy = false,
		priority = 100,
		config = function()
			require("which-key").setup({})
		end,
	},
	{
	"nvim-telescope/telescope.nvim",
		config = function()
		end,
	},
}, {
	defaults = {
		lazy = true,
	},
})

require("core.global")
