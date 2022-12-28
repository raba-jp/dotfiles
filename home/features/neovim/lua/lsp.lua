require("lsp-inlayhints").setup()
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

local cmp = require("cmp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local lspconfig = require("lspconfig")

lspconfig["bashls"].setup({
	capabilities = capabilities,
})

lspconfig["bufls"].setup({
	capabilities = capabilities,
})

lspconfig["clojure_lsp"].setup({
	capabilities = capabilities,
})

lspconfig["dagger"].setup({
	capabilities = capabilities,
})

lspconfig["dartls"].setup({
	capabilities = capabilities,
})

lspconfig["dockerls"].setup({
	capabilities = capabilities,
})

lspconfig["gopls"].setup({
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
	capaabilities = capabilities,
})

lspconfig["jsonnet_ls"].setup({
	capaabilities = capabilities,
})

lspconfig["nil_ls"].setup({
	capabilities = capabilities,
})

lspconfig["rust_analyzer"].setup({
	capaabilities = capabilities,
})

lspconfig["solargraph"].setup({
	capaabilities = capabilities,
})

lspconfig["sumneko_lua"].setup({
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
	capaabilities = capabilities,
})

lspconfig["terraformls"].setup({
	capaabilities = capabilities,
})

lspconfig["tsserver"].setup({
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
	capaabilities = capabilities,
})

lspconfig["zls"].setup({
	capaabilities = capabilities,
})
cmp.setup({
	mapping = {
		["<C-Space>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),

		["<Tab>"] = function(fallback)
			if not cmp.select_next_item() then
				if vim.bo.buftype ~= "prompt" and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,

		["<S-Tab>"] = function(fallback)
			if not cmp.select_prev_item() then
				if vim.bo.buftype ~= "prompt" and has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end
		end,
	},

	snippet = {
		-- We recommend using *actual* snippet engine.
		-- It's a simple implementation so it might not work in some of the cases.
		expand = function(args)
			local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
			local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
			local indent = string.match(line_text, "^%s*")
			local replace = vim.split(args.body, "\n", true)
			local surround = string.match(line_text, "%S.*") or ""
			local surround_end = surround:sub(col)

			replace[1] = surround:sub(0, col - 1) .. replace[1]
			replace[#replace] = replace[#replace] .. (#surround_end > 1 and " " or "") .. surround_end
			if indent ~= "" then
				for i, line in ipairs(replace) do
					replace[i] = indent .. line
				end
			end

			vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, replace)
		end,
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "nvim_lsp_signature_help" },
		{ name = "vsnip" },
	}, {
		{ name = "buffer" },
	}),
})

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
