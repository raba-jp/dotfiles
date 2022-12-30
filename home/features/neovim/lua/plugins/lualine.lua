local M ={}

M.config = function ()
			require("lualine").setup({
				options = {
					theme = "catppuccin",
				},
			})
end

return M
