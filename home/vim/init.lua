local fn = vim.fn
local cmd = vim.cmd
local opt = vim.o
local setmap = vim.api.nvim_set_keymap

-- Keybindings
setmap('i', 'jj', '<ESC>', {silent = true})
setmap('n', ';', ':', {noremap = true})
setmap('n', ':', ';', {noremap = true})
setmap('n', 'Y', 'y$', {noremap = true})
setmap('n', '<Tab>', '$', {noremap = true})
setmap('n', '<S-Tab>', '0', {noremap = true})
setmap('n', 'ZZ', '<Nop>', {noremap = true})
setmap('n', 'ZQ', '<Nop>', {noremap = true})
setmap('n', 'Q', '<Nop>', {noremap = true})
setmap('n', 's', '<Nop>', {noremap = true})
setmap('', '<C-j>', '<Plug>(edgemotion-j)', {})
setmap('', '<C-k>', '<Plug>(edgemotion-k)', {})
setmap('n', '<ESC><ESC>', ':nohlsearch<CR>', {noremap = true, silent = true})
setmap('i', '<Tab>', 'pumvisible() ? "<C-n>" : "<Tab>"', {noremap = true, expr = true})
setmap('i', '<S-Tab>', 'pumvisible() ? "<C-p>" : "<S-Tab>"', {noremap = true, expr = true})

-- Config
if fn.has('mac') then
    opt.clipboard = 'unnamedplus'
end
if fn.has('unix') == 1 then
    opt.clipboard = 'unnamed'
end
opt.encoding = 'UTF-8'
opt.swapfile = false
opt.smartindent = true
opt.smarttab = true
opt.visualbell = true
opt.hlsearch = true
opt.signcolumn = 'yes'
opt.smartcase = true
opt.ignorecase = true
opt.showmode = true
opt.completeopt = 'menuone,noinsert,noselect'
opt.termguicolors = true
opt.background = 'dark'

cmd('syntax on')
cmd('filetype plugin indent on')
cmd('colorscheme solarized8')

require('nvim-treesitter.configs').setup {
    ensure_installed = {
        "nix",
        "rust",
        "lua",
        "dart",
        "python",
        "typescript",
        "fish",
        "bash",
        "go",
        "yaml",
        "json",
        "graphql",
        "dockerfile",
    },
    highlight = {enable = true},
    indent = {enable = true},
    lsp_interop = {enable = true},
    refactor = {
        navigation = {enable = true},
        highlight_definitions = {enable = true},
        highlight_current_scope = {enable = true}
    },
    rainbow = {enable = true}
}
