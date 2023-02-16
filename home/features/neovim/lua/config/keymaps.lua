local setkeymap = vim.api.nvim_set_keymap

setkeymap("i", "jj", "<ESC>", { silent = true })

-- buffers
setkeymap("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
setkeymap("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Previous buffer" })
setkeymap("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First buffer" })
setkeymap("n", "<leader>bl", "<cmd>blast<cr>", { desc = "Last buffer" })
