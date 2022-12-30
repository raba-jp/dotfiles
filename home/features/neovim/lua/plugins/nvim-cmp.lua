local M = {}

M.config = function()
	local cmp = require("cmp")
	local luasnip = require("luasnip")

	local has_words_before = function()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
	end

	cmp.setup({
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
			-- We recommend using *actual* snippet engine.
			-- It's a simple implementation so it might not work in some of the cases.
			expand = function(args)
				local line_num, col = unpack(vim.api.nvim_win_get_cursor(0))
				local line_text = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, true)[1]
				local indent = string.match(line_text, "^%s*")
				local replace = vim.split(args.body, "\n", { trimempty = true })
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
end

return M
