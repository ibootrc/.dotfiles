return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require "null-ls"

    null_ls.setup {
      sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.shfmt,
      },
      on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })

          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }

          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                bufnr = bufnr,
                filter = function(format_client)
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
