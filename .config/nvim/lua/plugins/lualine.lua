return {
	'nvim-lualine/lualine.nvim',
	config = function()
		local config = require("lualine")
		config.setup({
			options = {
				icons_enabled = true,
				theme = 'auto',
			}
		})

	end
}
