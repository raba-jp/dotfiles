return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
		},
		config = function(_, opts)
			vim.o.timeout = true
			vim.o.timeoutlen = 300

			local wk = require("which-key")
			wk.setup(opts)
			wk.register({
				mode = { "n", "v" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>n"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+goto" },
				["<leader>w"] = { name = "+window" },
				["<leader>t"] = { name = "+term/test" },
				["<leader>s"] = { name = "+select" },
				["<leader>x"] = { name = "+none" },
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = "BufReadPre",
		config = true,
	},
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = 'nix-shell -p gnumake clang --run "make"',
			},
			"nvim-telescope/telescope-file-browser.nvim",
		},
		opts = function()
			local actions = require("telescope.actions")
			local fb_actions = require("telescope").extensions.file_browser.actions

			return {
				defaults = {
					mappings = {
						i = {
							["jj"] = actions.close,
						},
					},
					prompt_prefix = " ",
					selection_caret = " ",
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
					file_browser = {
						mappings = {
							["i"] = {
								["<C-o>"] = fb_actions.open,
								["<C-s>"] = fb_actions.toggle_all,
								["<C-h>"] = fb_actions.toggle_hidden,
								["<C-g>"] = fb_actions.goto_parent_dir,
								["<C-f>"] = fb_actions.toggle_browser,
							},
						},
					},
				},
			}
		end,
		config = function(_, opts)
			require("telescope").setup(opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("file_browser")
		end,
		keys = {
			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffer",
			},
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find file in current working directory",
			},
			{
				"<leader>fg",
				function()
					require("telescope.builtin").git_files()
				end,
				desc = "Find file through the output of git ls-files command",
			},
			{
				"<leader>fr",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Search for a string in current working directory",
			},
			{
				"<leader>fe",
				":Telescope file_browser path=%:p:h select_buffer=true<CR>",
				desc = "File browser",
			},
		},
	},
	{
		"echasnovski/mini.bufremove",
		keys = {
			{
				"<leader>bd",
				function()
					require("mini.bufremove").delete(0, false)
				end,
				desc = "Delete Buffer",
			},
			{
				"<leader>bD",
				function()
					require("mini.bufremove").delete(0, true)
				end,
				desc = "Delete Buffer (Force)",
			},
		},
	},
	{
		"echasnovski/mini.comment",
		event = "VeryLazy",
		dependencies = {
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
	},
	{
		"petertriho/nvim-scrollbar",
		event = "VeryLazy",
		dependencies = {
			"kevinhwang91/nvim-hlslens",
		},
		opts = {
			handlers = {
				cursor = true,
				diagnostic = true,
				gitsigns = true,
				search = true,
			},
		},
		keys = {
			{ "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]] },
			{ "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]] },
			{ "*", [[*<Cmd>lua require('hlslens').start()<CR>]] },
			{ "#", [[#<Cmd>lua require('hlslens').start()<CR>]] },
			{ "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]] },
			{ "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]] },
			{ "<ESC>", "<Cmd>noh<CR>" },
		},
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>sn",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Jump",
			},
			{
				"<leader>st",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Jump to treesitter node",
			},
			{
				"<leader>sm",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote operator",
			},
			{
				"<leader>sr",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Search uses treesitter",
			},
		},
	},
}
