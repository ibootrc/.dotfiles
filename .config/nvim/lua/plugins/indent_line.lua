return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufRead", "InsertEnter", "BufNewFile" },
	lazy = true,
	opts = {
		indent = {
			char = "|",
			tab_char = "|",
		},
	},
	main = "ibl",
}
