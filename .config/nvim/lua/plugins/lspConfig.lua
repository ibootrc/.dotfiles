return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    { "j-hui/fidget.nvim", opts = {} }, -- optional LSP status
    "saghen/blink.cmp", -- completion integration
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    -- Common on_attach
    local function on_attach(client, bufnr)
      local map = function(keys, func, desc, mode)
        mode = mode or "n"
        vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
      end

      map("grn", vim.lsp.buf.rename, "Rename")
      map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
      map("grD", vim.lsp.buf.declaration, "Goto Declaration")

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
            runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
            workspace = {
              library = { vim.fn.stdpath "config", vim.fn.getcwd() },
              checkThirdParty = false,
            },
          },
        },
      },
      html = {},
      ts_ls = {},
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
