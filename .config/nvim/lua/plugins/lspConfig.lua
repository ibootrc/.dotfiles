return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "saghen/blink.cmp",
    { "mason-org/mason.nvim", opts = {} },
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
      -- Lua (your optimized setup, preserved)
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

      -- HTML (correct formatter control)
      html = {
        init_options = {
          provideFormatter = false, -- official way to disable formatting
        },
        settings = {
          html = {
            hover = { documentation = true, references = true },
            validate = true,
            suggest = { html5 = true },
          },
        },
      },
      -- CSS / SCSS
      cssls = {
        settings = {
          css = { validate = true },
          scss = { validate = true },
          less = { validate = true },
        },
        -- TailwindCSS
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
        -- JSON
        jsonls = {
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },
      },
      -- TypeScript / JavaScript
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
    -- Setup servers using the new API
    for name, opts in pairs(servers) do
      opts =
        vim.tbl_deep_extend("force", { on_attach = on_attach, capabilities = capabilities }, opts)
      vim.lsp.config(name, opts)
      vim.lsp.enable(name)
    end
  end,
}
