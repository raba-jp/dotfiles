local M = {}

M.config = function()
	require("bufferline").setup({
		highlights = require("catppuccin.groups.integrations.bufferline").get(),
	})
end

return M
