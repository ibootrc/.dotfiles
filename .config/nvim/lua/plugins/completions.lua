return {
  {
    "saghen/blink.cmp",
    version = "1.*",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local blink = require "blink.cmp"

      blink.setup {
        keymap = {
          insert = {
            ["<C-Space>"] = "trigger_completion",
            ["<CR>"] = "confirm_completion",
            ["<C-e>"] = "abort_completion",
            ["<C-b>"] = "scroll_docs_up",
            ["<C-f>"] = "scroll_docs_down",
          },
        },
        sources = {
          providers = {
            lsp = {},
            snippets = {
              opts = {
                friendly_snippets = true,
                search_paths = { vim.fn.stdpath "config" .. "/snippets" },
              },
            },
            buffer = {},
          },
        },
        completion = {
          documentation = { auto_show = true },
        },
        fuzzy = {
          implementation = "prefer_rust_with_warning",
        },
      }
    end,
  },
}
