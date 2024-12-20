return {
	'ibootrc/archie.nvim',
	lazy = false,
	priority = 1000,
	init = function()
		vim.cmd("colorscheme archie")
	end
}
