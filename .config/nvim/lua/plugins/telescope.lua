return {
	"nvim-telescope/telescope.nvim",
	priority = 1000,
	dependencies = {
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
		"nvim-telescope/telescope-file-browser.nvim",
		"nvim-tree/nvim-web-devicons",
		-- Add telescope-undo.nvim
		{ "debugloop/telescope-undo.nvim" },
	},
	keys = {
		{
			";f",
			function()
				local builtin = require("telescope.builtin")
				builtin.find_files({
					no_ignore = false,
					hidden = true,
					file_ignore_patterns = { "node_modules/*" }, -- Exclude node_modules
				})
			end,
			desc = "Lists files in your current working directory, respects .gitignore",
		},
		{
			";r",
			function()
				local builtin = require("telescope.builtin")
				builtin.live_grep()
			end,
			desc = "Search for a string in your current working directory and get results live as you type",
		},
		{
			"\\\\",
			function()
				local builtin = require("telescope.builtin")
				builtin.buffers()
			end,
			desc = "Lists open buffers",
		},
		{
			";;",
			function()
				local builtin = require("telescope.builtin")
				builtin.resume()
			end,
			desc = "Resume the previous telescope picker",
		},
		{
			";e",
			function()
				local builtin = require("telescope.builtin")
				builtin.diagnostics()
			end,
			desc = "Lists Diagnostics for all open buffers or a specific buffer",
		},
		{
			";s",
			function()
				local builtin = require("telescope.builtin")
				builtin.treesitter()
			end,
			desc = "Lists Function names, variables, from Treesitter",
		},
		{
			";c",
			function()
				local builtin = require("telescope.builtin")
				builtin.current_buffer_fuzzy_find() -- Search only in the open buffer
			end,
			desc = "Live grep in the current buffer",
		},
		{
			"sf",
			function()
				local telescope = require("telescope")

				local function telescope_buffer_dir()
					return vim.fn.expand("%:p:h")
				end

				telescope.extensions.file_browser.file_browser({
					path = "%:p:h",
					cwd = telescope_buffer_dir(),
					respect_gitignore = false,
					hidden = true,
					grouped = true,
					previewer = false,
					initial_mode = "normal",
					layout_config = { height = 30 },
				})
			end,
			desc = "Open File Browser with the path of the current buffer",
		},
		-- Add keybinding for undo history
		{
			";u",
			function()
				require("telescope").extensions.undo.undo()
			end,
			desc = "Open undo history",
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local fb_actions = require("telescope").extensions.file_browser.actions

		opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
			wrap_results = true,
			layout_strategy = "horizontal",
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
			winblend = 0,
			mappings = {
				n = {},
			},
		})
		opts.pickers = {
			diagnostics = {
				theme = "ivy",
				initial_mode = "normal",
				layout_config = {
					preview_cutoff = 9999,
				},
			},
		}
		opts.extensions = {
			file_browser = {
				theme = "dropdown",
				hijack_netrw = true,
				mappings = {
					["n"] = {
						["N"] = fb_actions.create,
						["h"] = fb_actions.goto_parent_dir,
						["<C-u>"] = function(prompt_bufnr)
							for _ = 1, 10 do
								actions.move_selection_previous(prompt_bufnr)
							end
						end,
						["<C-d>"] = function(prompt_bufnr)
							for _ = 1, 10 do
								actions.move_selection_next(prompt_bufnr)
							end
						end,
					},
				},
			},
		}
		telescope.setup(opts)

		-- Load Telescope Extensions
		telescope.load_extension("fzf")
		telescope.load_extension("file_browser")
		telescope.load_extension("undo") -- Load undo extension
	end,

	-- Apply highlights explicitly after Telescope setup
	vim.schedule(function()
		vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#A8D8E6", bg = "#4a4a4a", bold = true })
		vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#FFB86C" })
		vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#56B6C2" })
	end),
}
