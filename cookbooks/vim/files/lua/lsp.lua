local has = vim.fn.has

local system_name
if has("mac") == 1 then
    system_name = "macOS"
elseif has("unix") == 1 then
    system_name = "Linux"
elseif has("win32") == 1 then
    system_name = "Windows"
else
    print("Unsupported system for sumneko lua language server")
end

local home = os.getenv("HOME")

local lsp = require('lspconfig')

local sumneko_root_path = home .. "/.local/share/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/" .. system_name ..
                           "/lua-language-server"
require('lspconfig').sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    settings = {
        Lua = {
            diagnostics = {globals = {'vim'}},
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }
}

local lsp_server_path = home .. "/.local/share/vim-lsp-settings/servers"
lsp.gopls.setup {cmd = {lsp_server_path .. "/gopls/gopls"}}

require('completion').on_attach()
vim.cmd [[augroup lsp_aucmds]]
vim.cmd [[au BufEnter * lua require('completion').on_attach()]]
vim.cmd [[augroup END]]
