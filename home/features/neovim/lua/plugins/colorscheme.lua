return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		local highlightOverrides = function(flavor)
			local cp = require("catppuccin.palettes").get_palette(flavor)
			return {
				-- Telescope
				TelescopeBorder = { fg = cp.mantle, bg = cp.mantle },
				TelescopeSelectionCaret = { fg = cp.flamingo, bg = cp.mantle },
				TelescopeMatching = { fg = cp.peach },
				TelescopeNormal = { fg = cp.text, bg = cp.mantle },
				TelescopeSelection = { fg = cp.text, bg = cp.surface1 },
				TelescopeMultiSelection = { fg = cp.text, bg = cp.surface2 },
				TelescopeTitle = { fg = cp.mantle, bg = cp.mantle },
				TelescopePreviewTitle = { fg = cp.mantle, bg = cp.mantle },
				TelescopePromptTitle = { fg = cp.surface0, bg = cp.surface0 },
				TelescopePromptNormal = { fg = cp.text, bg = cp.surface0 },
				TelescopePromptBorder = { fg = cp.surface0, bg = cp.surface0 },
				-- Lspsaga
				SagaNormal = { bg = cp.mantle },
				SagaBorder = { bg = cp.mantle },
			}
		end

		require("catppuccin").setup({
			highlight_overrides = {
				latte = highlightOverrides("latte"),
				frappe = highlightOverrides("frappe"),
				macchiato = highlightOverrides("macchiato"),
				mocha = highlightOverrides("mocha"),
			},
			integrations = {
				cmp = true,
				telescope = true,
				gitsigns = true,
				leap = true,
				notify = true,
				treesitter = true,
				treesitter_context = true,
				which_key = true,
				neotree = true,
				neotest = true,
				noice = true,
				lsp_saga = true,
				mini = true,
				indent_blankline = {
					enabled = true,
				},
				navic = {
					enabled = true,
				},
				lsp_trouble = true,
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

		require("catppuccin").load()
	end,
}
