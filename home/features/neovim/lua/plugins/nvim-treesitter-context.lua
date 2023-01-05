local M = {}

M.config = function()
	require("treesitter-context").setup({
		enable = true,
	})
end

return M
