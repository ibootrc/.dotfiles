return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    lazy = true, -- lazy load LSP config to improve startup
    event = { "BufReadPre", "BufNewFile" }, -- start LSP only when buffer is opened
    config = function()
      local mason = require "mason"
      local mason_lspconfig = require "mason-lspconfig"

      mason.setup()
      mason_lspconfig.setup {
        ensure_installed = { "lua_ls" },
        automatic_installation = true,
      }

      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      end

      local servers = { "lua_ls" }

      for _, server in ipairs(servers) do
        local config = {
          on_attach = on_attach,
          flags = { debounce_text_changes = 150 }, -- smaller debounce = faster response
        }

        if server == "lua_ls" then
          config.settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file("", false),
                maxPreload = 500, -- limit number of files indexed at startup
                preloadFileSize = 50, -- skip large files
                ignoreDir = { "node_modules", ".git", "packer_compiled.lua" }, -- skip heavy folders
              },
              telemetry = { enable = false },
            },
          }
        end

        -- Lazy attach: only attach when filetype matches
        vim.api.nvim_create_autocmd("FileType", {
          pattern = { "lua" }, -- only for Lua files
          callback = function()
            vim.lsp.config(server).setup(config)
            vim.lsp.enable(server)
          end,
        })
      end
    end,
  },
}
