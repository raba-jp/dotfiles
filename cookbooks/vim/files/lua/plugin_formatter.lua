require('formatter').setup({
    logging = false,
    filetype = {
        javascript = {
            -- prettier
            function()
                return {
                    exe = "prettier",
                    args = {
                        "--stdin-filepath", vim.api.nvim_buf_get_name(0),
                        '--single-quote'
                    },
                    stdin = true
                }
            end
        },
        rust = {
            -- Rustfmt
            function()
                return {exe = "rustfmt", args = {"--emit=stdout"}, stdin = true}
            end
        },
        lua = {
            -- lua-format
            function()
                return {exe = "lua-format", args = {}, stdin = true}
            end
        }
    }
})

vim.cmd [[augroup FormatAutogroup]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd BufWritePost * FormatWrite]]
vim.cmd [[augroup END]]
