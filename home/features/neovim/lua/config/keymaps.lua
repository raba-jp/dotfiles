local setkeymap = vim.api.nvim_set_keymap

setkeymap("i", "jj", "<ESC>", { silent = true })

-- windows
setkeymap("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
setkeymap("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
setkeymap("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
setkeymap("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
setkeymap("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
setkeymap("n", "<leader>|", "<C-W>v", { desc = "Split window right" })
setkeymap("n", "<leader>wn", "<C-W>w", { desc = "Move next window" })
setkeymap("n", "<leader>wp", "<C-W>W", { desc = "Moce previous window" })

-- buffers
setkeymap("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
setkeymap("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Previous buffer" })
setkeymap("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First buffer" })
setkeymap("n", "<leader>bl", "<cmd>blast<cr>", { desc = "Last buffer" })
