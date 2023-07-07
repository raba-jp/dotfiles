function on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

return {
	{
		"neovim/nvim-lspconfig",
		event = "BufReadPre",
		dependencies = {
			{
				"lukas-reineke/lsp-format.nvim",
				config = true,
			},
			"hrsh7th/cmp-nvim-lsp",
			"SmiteshP/nvim-navic",
		},
		opts = function()
			return {
				servers = {
					bashls = {},
					bufls = {},
					clojure_lsp = {},
					dagger = {},
					dartls = {},
					dockerls = {},
					gopls = {
						settings = {
							gopls = {
								hints = {
									assignVariableTypes = true,
									compositeLiteralFields = true,
									compositeLiteralTypes = true,
									constantValues = true,
									functionTypeParameters = true,
									parameterNames = true,
									rangeVariableTypes = true,
								},
								analyses = {
									unusedparams = true,
								},
								gofumpt = true,
								staticcheck = true,
							},
						},
						init_options = {
							usePlaceholders = true,
						},
					},
					graphql = {},
					jsonnet_ls = {},
					nil_ls = {},
					rust_analyzer = {},
					solargraph = {},
					lua_ls = {
						settings = {
							Lua = {
								runtime = {
									version = "LuaJIT",
									path = vim.split(package.path, ";"),
								},
								diagnostics = {
									globals = { "vim", "describe", "it", "before_each", "after_each" },
								},
								workspace = {
									library = {
										[vim.fn.expand("$VIMRUNTIME/lua")] = true,
										[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
									},
									maxPreload = 2000,
									preloadFileSize = 50000,
								},
								completion = { callSnippet = "Both" },
								telemetry = { enable = false },
								hint = {
									enable = true,
								},
							},
						},
					},
					taplo = {},
					terraformls = {},
					tsserver = {
						settings = {
							javascript = {
								inlayHints = {
									includeInlayEnumMemberValueHints = true,
									includeInlayFunctionLikeReturnTypeHints = true,
									includeInlayFunctionParameterTypeHints = true,
									includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
									includeInlayParameterNameHintsWhenArgumentMatchesName = true,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayVariableTypeHints = true,
								},
							},
							typescript = {
								inlayHints = {
									includeInlayEnumMemberValueHints = true,
									includeInlayFunctionLikeReturnTypeHints = true,
									includeInlayFunctionParameterTypeHints = true,
									includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
									includeInlayParameterNameHintsWhenArgumentMatchesName = true,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayVariableTypeHints = true,
								},
							},
						},
					},
					yamlls = {
						settings = {
							yaml = {
								keyOrdering = false,
							},
						},
					},
					zls = {},
				},
			}
		end,
		config = function(_, opts)
			local lspconfig = require("lspconfig")

			on_attach(function(client, buf)
				require("lsp-format").on_attach(client, buf)

				if client.server_capabilities.documentSymbolProvider then
					require("nvim-navic").attach(client, buf)
				end

				vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
			end)

			for server, server_opts in pairs(opts.servers) do
				server_opts.capabilities = require("cmp_nvim_lsp").default_capabilities()

				lspconfig[server].setup(server_opts)
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "VeryLazy",
		dependencies = {
			"lukas-reineke/lsp-format.nvim",
			"nvim-lua/plenary.nvim",
		},
		config = function()
			local null_ls = require("null-ls")

			null_ls.setup({
				-- on_attach = require("lsp-format").on_attach,
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.alejandra,
					null_ls.builtins.formatting.buildifier,
					null_ls.builtins.formatting.cljstyle,
					null_ls.builtins.formatting.cueimports,
					null_ls.builtins.formatting.cue_fmt,
					null_ls.builtins.formatting.goimports,
					null_ls.builtins.formatting.rego,
					null_ls.builtins.formatting.shfmt,
					null_ls.builtins.formatting.taplo,
					null_ls.builtins.formatting.yamlfmt,
					null_ls.builtins.formatting.zigfmt,
					null_ls.builtins.code_actions.statix,
					null_ls.builtins.diagnostics.selene,
					null_ls.builtins.diagnostics.actionlint,
					null_ls.builtins.diagnostics.buf,
					null_ls.builtins.diagnostics.clj_kondo,
					null_ls.builtins.diagnostics.deadnix,
					null_ls.builtins.diagnostics.dotenv_linter,
					null_ls.builtins.diagnostics.golangci_lint,
					null_ls.builtins.diagnostics.hadolint,
					null_ls.builtins.diagnostics.shellcheck,
					null_ls.builtins.diagnostics.statix,
				},
			})
		end,
	},
	{
		"lvimuser/lsp-inlayhints.nvim",
		event = "BufReadPre",
		config = function()
			require("lsp-inlayhints").setup({})
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
	},
	{
		"nvimdev/lspsaga.nvim",
		cmd = "Lspsaga",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"nvim-treesitter/nvim-treesitter",
			"catppuccin/nvim",
		},
		opts = function()
			return {
				ui = {
					title = false,
					border = "solid",
					winblend = 0,
					expand = "",
					collapse = "",
					code_action = "",
					incoming = " ",
					outgoing = " ",
					hover = " ",
					kind = require("catppuccin.groups.integrations.lsp_saga").custom_kind(),
				},
				symbol_in_winbar = {
					enable = false,
				},
			}
		end,
		keys = {
			{
				"<leader>na",
				"<cmd>Lspsaga code_action<CR>",
				desc = "Run code actions",
			},
			{
				"<leader>nn",
				"<cmd>Lspsaga lsp_finder<CR>",
				desc = "Show the defintion, reference and implementation",
			},
			{
				"<leader>nr",
				"<cmd>Lspsaga rename<CR>",
				desc = "Rename",
			},
			{
				"<leader>no",
				"<cmd>Lspsaga outline<CR>",
				desc = "Show outline",
			},
			{
				"<leader>nd",
				"<cmd>Lspsaga hover_doc<CR>",
				desc = "Show document",
			},
		},
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		event = "VeryLazy",
		opts = {},
	},
}
