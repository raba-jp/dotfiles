local M = {}

M.init = function()
			vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])
		end

M.config = function ()
require("lsp-format").setup({})

local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

lspconfig["bashls"].setup({
	on_attach = require("lsp-format").on_attach,
	capabilities = capabilities,
})

lspconfig["bufls"].setup({
	on_attach = require("lsp-format").on_attach,
	capabilities = capabilities,
})

lspconfig["clojure_lsp"].setup({
	on_attach = require("lsp-format").on_attach,
	capabilities = capabilities,
})

lspconfig["dagger"].setup({
	on_attach = require("lsp-format").on_attach,
	capabilities = capabilities,
})

lspconfig["dartls"].setup({
	on_attach = require("lsp-format").on_attach,
	capabilities = capabilities,
})

lspconfig["dockerls"].setup({
	on_attach = require("lsp-format").on_attach,
	capabilities = capabilities,
})

lspconfig["gopls"].setup({
	on_attach = require("lsp-format").on_attach,
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
		},
	},
	capabilities = capabilities,
})

lspconfig["graphql"].setup({
	on_attach = require("lsp-format").on_attach,
	capaabilities = capabilities,
})

lspconfig["jsonnet_ls"].setup({
	on_attach = require("lsp-format").on_attach,
	capaabilities = capabilities,
})

lspconfig["nil_ls"].setup({
	on_attach = require("lsp-format").on_attach,
	capabilities = capabilities,
})

lspconfig["rust_analyzer"].setup({
	on_attach = require("lsp-format").on_attach,
	capaabilities = capabilities,
})

lspconfig["solargraph"].setup({
	on_attach = require("lsp-format").on_attach,
	capaabilities = capabilities,
})

lspconfig["sumneko_lua"].setup({
	on_attach = require("lsp-format").on_attach,
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
	capaabilities = capabilities,
})

lspconfig["taplo"].setup({
	on_attach = require("lsp-format").on_attach,
	capaabilities = capabilities,
})

lspconfig["terraformls"].setup({
	on_attach = require("lsp-format").on_attach,
	capaabilities = capabilities,
})

lspconfig["tsserver"].setup({
	on_attach = require("lsp-format").on_attach,
	disable_formatting = true,
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
	capaabilities = capabilities,
})

lspconfig["yamlls"].setup({
	on_attach = require("lsp-format").on_attach,
	capaabilities = capabilities,
})

lspconfig["zls"].setup({
	on_attach = require("lsp-format").on_attach,
	capaabilities = capabilities,
})
end

return M
