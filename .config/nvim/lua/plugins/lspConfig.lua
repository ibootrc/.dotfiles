return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    -- Mason with Rounded UI and Premium Icons
    {
      "williamboman/mason.nvim",
      opts = {
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      },
    },
    { "b0o/schemastore.nvim", lazy = true },
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Common on_attach
    local function on_attach(client, bufnr)
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
      end
      map("gr", vim.lsp.buf.rename, "Rename")
      map("gd", vim.lsp.buf.definition, "Goto Definition")
      map("gr", vim.lsp.buf.references, "References")

      -- Document highlight only for small buffers
      if client.supports_method "textDocument/documentHighlight" then
        if vim.api.nvim_buf_line_count(bufnr) < 5000 then
          local highlight_grp = vim.api.nvim_create_augroup("lsp_doc_highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = bufnr,
            group = highlight_grp,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = bufnr,
            group = highlight_grp,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end
    end

    -- Servers definition
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT",
              path = { "lua/?.lua", "lua/?/init.lua" },
            },
            workspace = {
              library = {
                vim.fn.stdpath "config",
                vim.fn.getcwd(),
              },
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      },
      html = {
        init_options = {
          provideFormatter = false,
        },
        settings = {
          html = {
            hover = { documentation = true, references = true },
            validate = true,
            suggest = { html5 = true },
          },
        },
      },
      cssls = {
        settings = {
          css = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
      },
      tailwindcss = {
        settings = {
          tailwindCSS = {
            includeLanguages = {
              ["typescriptreact"] = "html",
              ["javascriptreact"] = "html",
              ["html"] = "html",
            },
            experimental = {
              classRegex = { 'className="([^"]*)"' },
            },
          },
        },
      },
      jsonls = {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },
      ts_ls = {
        init_options = {
          maxTsServerMemory = 4096,
          disableAutomaticTypingAcquisition = true,
        },
        settings = {
          typescript = {
            format = { enable = false },
            inlayHints = {
              includeInlayParameterNameHints = "none",
              includeInlayVariableTypeHints = false,
              includeInlayFunctionParameterTypeHints = false,
            },
            preferences = {
              importModuleSpecifierPreference = "relative",
            },
          },
          javascript = {
            format = { enable = false },
          },
        },
      },
    }

    -- Setup servers
    for name, opts in pairs(servers) do
      opts =
        vim.tbl_deep_extend("force", { on_attach = on_attach, capabilities = capabilities }, opts)
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end

    -- Glass UI: Global Float and Mason Border colors
    vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#34393e", bg = "NONE" })
    vim.api.nvim_set_hl(0, "MasonBorder", { fg = "#34393e", bg = "NONE" })
  end,
}
