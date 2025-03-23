return {
	"nvimtools/none-ls.nvim",
	config = function()
		local none_ls = require("null-ls")

		none_ls.setup({
			sources = {
				none_ls.builtins.formatting.prettier,  -- JavaScript/TypeScript
				none_ls.builtins.formatting.stylua,    -- Lua
				none_ls.builtins.formatting.black,     -- Python
				none_ls.builtins.formatting.shfmt,     -- Shell scripts
			},
		})

		-- Auto-format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function()
				vim.lsp.buf.format({
					async = false,
					filter = function(client)
						return client.supports_method("textDocument/formatting")
					end,
				})
			end,
		})
	end,
}
