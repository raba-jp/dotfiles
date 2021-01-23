local packer = nil
local function init()
	if packer == nil then
		packer = require('packer')
		packer.init({disable_commands = true})
	end

	local use = packer.use
	packer.reset()

use {'wbthomason/packer.nvim', opt = true} -- Plugin manager
use {'lifepillar/vim-solarized8'} -- Colorscheme
use {'editorconfig/editorconfig-vim'}	-- Editorconfig

use {
	{'neovim/nvim-lspconfig'},
	'nvim-lua/lsp-status.nvim', {
		'nvim-lua/completion-nvim',
		after = 'nvim-lspconfig',
		config = function()
			vim.lsp.set_log_level("debug")
			require("lsp")
			require('completion').on_attach()

			vim.cmd [[augroup lsp_aucmds]]
			vim.cmd [[au BufEnter * lua require('completion').on_attach()]]
			vim.cmd [[augroup END]]

		end,
	},
	{'nvim-treesitter/completion-treesitter', opt = true},
	{
		'nvim-treesitter/nvim-treesitter',
		requires = {
			{ 'nvim-treesitter/nvim-treesitter-refactor', after = 'nvim-treesitter'},
			{ 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' },
			{ 'romgrk/nvim-treesitter-context', after = 'nvim-treesitter' },
		},
		config = 'require("treesitter")',
		event = 'VimEnter *',
	},
}

use {'itchyny/lightline.vim'} -- Statusline
use { -- Fuzzy finder
	'nvim-telescope/telescope.nvim',
	config = [[require('telescope')]]
}

use {'haya14busa/vim-edgemotion'}
end

local plugins = setmetatable({}, {
	__index = function(_, key)
	init()
	return packer[key]
  end
})

return plugins
