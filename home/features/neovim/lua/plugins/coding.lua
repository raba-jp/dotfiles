return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = "InsertEnter",
		keys = { ":", "/" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
			{
				"L3MON4D3/LuaSnip",
				dependencies = {
					"rafamadriz/friendly-snippets",
					config = function()
						require("luasnip.loaders.from_vscode").lazy_load()
					end,
				},
				opts = {
					history = true,
					delete_check_events = "TextChanged",
				},
			},
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local has_words_before = function()
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			return {
				mapping = {
					["<CR>"] = cmp.mapping.confirm({ select = true }),
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
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "nvim_lsp_signature_help" },
					{ name = "nvim_lsp_signature_symbols" },
					{ name = "copilot" },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
				}),
				formatting = {
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. strings[1] .. " "
						kind.menu = "    (" .. strings[2] .. ")"

						return kind
					end,
				},
				preselect = cmp.PreselectMode.None,
				matching = {
					disallow_fuzzy_matching = false,
					disallow_partial_matching = false,
				},
			}
		end,
		config = function(_, opts)
			local cmp = require("cmp")
			cmp.setup(opts)

			cmp.setup.cmdline({ "/", "?" }, {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})

			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	},
	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		config = function(_, opts)
			require("mini.pairs").setup(opts)
		end,
	},
	{
		"nvim-neotest/neotest",
		event = "VeryLazy",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-neotest/neotest-go",
			"rouge8/neotest-rust",
		},
		opts = function()
			return {
				adapters = {
					require("neotest-go")({
						experimental = {
							test_table = true,
						},
						args = { "-count=1", "-timeout=60s" },
					}),
					require("neotest-rust"),
				},
			}
		end,
		config = function(_, opts)
			require("neotest").setup(opts)
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
		end,
		keys = {
			{
				"<leader>tx",
				function()
					require("neotest").run.run()
				end,
				desc = "Run nearest test",
			},
			{
				"<leader>tc",
				function()
					require("neotest").run.run(vim.fn.expand("%"))
				end,
				desc = "Run current file",
			},
			{
				"<leader>ts",
				function()
					require("neotest").summary.toggle()
				end,
				desc = "Toggle test summary",
			},
			{
				"<leader>to",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle test output",
			},
			{
				"<leader>tw",
				function()
					require("neotest").output_panel.toggle()
				end,
				desc = "Toggle test output window",
			},
		},
	},
	{
		"NMAC427/guess-indent.nvim",
		event = "VeryLazy",
		opts = {
			auto_cmd = true,
			buftype_exclude = {
				"help",
				"nofile",
				"terminal",
				"prompt",
			},
			filetype_exclude = {
				"dashboard",
				"lazy",
				"alpha",
				"help",
				"neo-tree",
				"Trouble",
				"netrw",
				"tutor",
			},
		},
	},
	{
		"stevearc/overseer.nvim",
		event = "VeryLazy",
		opts = {},
	},
	{
		"zbirenbaum/copilot.lua",
		name = "copilot",
		event = "VeryLazy",
		cmd = "Copilot",
		opts = {
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 50,
				keymap = {
					accept = "<C-l>",
					accept_word = false,
					accept_line = false,
					next = "<C-n>",
					prev = "<C-t>",
					dismiss = "<C-s>",
				},
			},
		},
	},
	{
		"NeogitOrg/neogit",
		cmd = "Neogit",
		dependencies = "nvim-lua/plenary.nvim",
	},
}
