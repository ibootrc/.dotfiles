return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require "null-ls"

    -- Define formatting sources
    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.prettier, -- JS/TS
        null_ls.builtins.formatting.stylua, -- Lua
        null_ls.builtins.formatting.black, -- Python
        null_ls.builtins.formatting.shfmt, -- Shell
      },
      -- Attach per buffer
      on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          -- Create a group to prevent duplicate autocmds
          local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })

          -- Clear existing autocmds for this buffer in the group
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }

          -- Auto-format on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                bufnr = bufnr,
                filter = function(format_client)
                  -- Only use null-ls for formatting
                  return format_client.name == "null-ls"
                end,
                async = false,
              }
            end,
          })
        end
      end,
    }
  end,
}
