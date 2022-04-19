local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
local lspconfig = require("lspconfig")
local lspformat = require("lsp-format")

local default_lsp_options = { capabilities = capabilities, on_attach = lspformat.on_attach }

lspconfig.gopls.setup(default_lsp_options)
lspconfig.rust_analyzer.setup(default_lsp_options)
lspconfig.rnix.setup(default_lsp_options)
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
