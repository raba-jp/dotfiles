require("lazy").setup({
	{ "gpanders/editorconfig.nvim", lazy = false, },
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = require("plugins.catppuccin").config,
	},
	{
		"nvim-lualine/lualine.nvim",
		lazy = false,
		config = require("plugins.lualine").config,
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false;
		dependencies = {
			"lukas-reineke/lsp-format.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		init = require("plugins.lspconfig").init,
		config = require("plugins.lspconfig").config,
	},
	{
		"hrsh7th/nvim-cmp",
		lazy = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
			"L3MON4D3/LuaSnip",
		},
		config = require("plugins.nvim-cmp").config,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "BufEnter",
		config = require("plugins.nvim-treesitter").config,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "BufEnter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		config = require("plugins.nvim-treesitter-context").config,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "BufEnter",
		init = require("plugins.lsp-inlayhints").init,
		config = require("plugins.lsp-inlayhints").config,
	},

	{
		"folke/noice.nvim",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		keys = { ":" },
		init = require("plugins.noice").init,
		config = require("plugins.noice").config,
	},
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
		event = "BufEnter",
		config = require("plugins.null-ls").config,
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
		dependencies = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
			},
			"nvim-telescope/telescope-ghq.nvim",
		},
		cmd = "Telescope",
		config = require("plugins.telescope").config,
	},
	{
		"akinsho/bufferline.nvim",
		lazy = false,
		config = require("plugins.bufferline").config,
	},
	{
		"ggandor/leap.nvim",
		event = "BufEnter",
		config = require("plugins.leap").config,
	},
}, {
	defaults = {
		lazy = true,
	},
})

require("core.global")
