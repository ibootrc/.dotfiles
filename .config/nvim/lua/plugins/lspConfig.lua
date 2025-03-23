return {
	-- Mason: LSP package manager
	{
		"williamboman/mason.nvim",
		lazy = false,
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason-LSPConfig: Bridges Mason with LSPConfig
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true, -- Automatically install missing LSP servers
		},
	},

	-- Neovim LSPConfig: Configures LSP servers
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			-- Function to run when an LSP attaches
			local function on_attach(client, bufnr)
				local opts = { buffer = bufnr }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
			end

			-- Fetch installed LSP servers from Mason
			require("mason-lspconfig").setup_handlers({
				-- Default handler for all installed servers
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
					})
				end,
			})
		end,
	},
}
