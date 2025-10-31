return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    lazy = false,
    config = function()
      local mason = require "mason"
      local mason_lspconfig = require "mason-lspconfig"
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason.setup()
      mason_lspconfig.setup {
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
      }

      local function on_attach(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      -- Define a server configuration for each installed server
      local servers = mason_lspconfig.get_installed_servers()
      for _, server in ipairs(servers) do
        local config = {
          capabilities = capabilities,
          on_attach = on_attach,
        }

        -- Lua-specific settings
        if server == "lua_ls" then
          config.settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" }, disable = { "assign-as-condition" } },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = { enable = false },
            },
          }
        end

        -- Register server using the new API
        vim.lsp.config[server] = vim.tbl_deep_extend("force", vim.lsp.config[server] or {}, config)
        vim.lsp.enable(server)
      end
    end,
  },
}
