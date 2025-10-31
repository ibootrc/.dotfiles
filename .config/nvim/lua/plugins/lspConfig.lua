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
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
      })

      local function on_attach(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      -- Get list of installed servers
      local servers = mason_lspconfig.get_installed_servers()

      for _, server in ipairs(servers) do
        local config = {
          capabilities = capabilities,
          on_attach = on_attach,
        }

        -- 🩵 Custom settings for Lua
        if server == "lua_ls" then
          config.settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = {
                globals = { "vim" },
                disable = { "assign-as-condition" },
              },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", true),
              },
              telemetry = { enable = false },
            },
          }
        end

        -- ✅ Use Neovim 0.11+ native LSP loader
        local ok, lspconfig_mod = pcall(require, "lspconfig.configs")
        local lsp = ok and vim.lsp or require("lspconfig")

        -- Define server configuration
        local server_config = vim.tbl_deep_extend("force", {}, config)

        -- New API: vim.lsp.start + vim.lsp.config
        if vim.lsp.start and vim.lsp.config then
          local new_cfg = vim.lsp.config(server, server_config)
          if new_cfg then
            vim.lsp.start(new_cfg)
          end
        else
          -- Backward compatibility for older nvim builds
          local ok2, old_lsp = pcall(require, "lspconfig")
          if ok2 and old_lsp[server] and old_lsp[server].setup then
            old_lsp[server].setup(server_config)
          end
        end
      end
    end,
  },
}
