local function map(mode, l, r, opts)
	opts = opts or {}
	vim.keymap.set(mode, l, r, opts)
end

map("i", "jj", "<ESC>", { silent = true })

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>wn", "<C-W>w", { desc = "Move next window" })
map("n", "<leader>wp", "<C-W>W", { desc = "Moce previous window" })

-- buffers
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprev<cr>", { desc = "Previous buffer" })
map("n", "<leader>bf", "<cmd>bfirst<cr>", { desc = "First buffer" })
map("n", "<leader>bl", "<cmd>blast<cr>", { desc = "Last buffer" })

-- LSP
map("n", "<leader>na", function()
	vim.lsp.buf.code_action()
end, { desc = "Run code action" })
