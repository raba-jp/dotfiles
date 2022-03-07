-- Keybindings
vim.api.nvim_set_keymap("i", "jj", "<ESC>", { silent = true })
vim.api.nvim_set_keymap("n", " ", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", ";", ":", { noremap = true })
vim.api.nvim_set_keymap("n", ":", ";", { noremap = true })
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })
vim.api.nvim_set_keymap("n", "<Tab>", "$", { noremap = true })
vim.api.nvim_set_keymap("n", "<S-Tab>", "0", { noremap = true })
vim.api.nvim_set_keymap("n", "ZZ", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "ZQ", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "Q", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "s", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("", "<C-j>", "<Plug>(edgemotion-j)", {})
vim.api.nvim_set_keymap("", "<C-k>", "<Plug>(edgemotion-k)", {})
vim.api.nvim_set_keymap("n", "<ESC><ESC>", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<Tab>", 'pumvisible() ? "<C-n>" : "<Tab>"', { noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<S-Tab>", 'pumvisible() ? "<C-p>" : "<S-Tab>"', { noremap = true, expr = true })

-- Config
if vim.fn.has("mac") then
	vim.o.clipboard = "unnamedplus"
end
if vim.fn.has("unix") == 1 then
	vim.o.clipboard = "unnamed"
end
