local packer = nil
local function init()
    if packer == nil then
        packer = require('packer')
        packer.init({disable_commands = true})
    end

    local use = packer.use
    packer.reset()

    use {'wbthomason/packer.nvim', opt = true} -- Plugin manager
    use {'sheerun/vim-polyglot'} -- Language config
    use {'lifepillar/vim-solarized8'} -- Colorscheme
    use {'editorconfig/editorconfig-vim'} -- Editorconfig
    use {'mattn/vim-lsp-settings', opt = true}

    use {'neovim/nvim-lspconfig'}
    use {'nvim-lua/lsp-status.nvim'}
    use {
        'nvim-lua/completion-nvim',
        event = 'VimEnter *',
        after = 'nvim-lspconfig',
        config = 'require("lsp")'
    }
    use {
        {'nvim-treesitter/completion-treesitter', opt = true}, {
            'nvim-treesitter/nvim-treesitter',
            event = 'VimEnter *',
            requires = {
                {
                    'nvim-treesitter/nvim-treesitter-refactor',
                    after = 'nvim-treesitter'
                },
                {
                    'nvim-treesitter/nvim-treesitter-textobjects',
                    after = 'nvim-treesitter'
                }, {'romgrk/nvim-treesitter-context', after = 'nvim-treesitter'}
            },
            config = "require('plugin_treesitter')"
        }
    }

    use {'itchyny/lightline.vim'} -- Statusline
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-ghq.nvim'
        },
        config = 'require("plugin_telescope")'
    }

    use {'haya14busa/vim-edgemotion'}
    use {'cohama/lexima.vim'}
    use {
        'rhysd/clever-f.vim',
        config = function()
            vim.g.clever_f_smart_case = 1
            vim.g.clever_f_mark_char_color = 1
            vim.g.clever_f_use_migemo = 1
            vim.g.clever_f_fix_key_direction = 1
        end
    }
    use {'mhartington/formatter.nvim', config = 'require("plugin_formatter")'}
end

local plugins = setmetatable({}, {
    __index = function(_, key)
        init()
        return packer[key]
    end
})

return plugins
