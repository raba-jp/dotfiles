require("lsp-format").setup({})
vim.cmd("augroup Format")
vim.cmd("autocmd!")
vim.cmd("autocmd BufWritePost * Format")
vim.cmd("augroup END")