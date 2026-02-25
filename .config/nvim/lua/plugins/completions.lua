return {
  "saghen/blink.cmp",
  event = "InsertEnter", -- lazy load on first insert
  version = "1.*",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "2.*",
      build = (function()
        if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            -- Lazy-load only relevant languages
            require("luasnip.loaders.from_vscode").lazy_load {
              include = { "html", "javascript", "lua" },
            }
          end,
        },
      },
      opts = {},
    },
  },
  opts = {
    keymap = {
      preset = "default",
      ["<CR>"] = { "select_and_accept", "fallback" }, -- optimized Enter
    },

    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 }, -- less overhead
    },

    sources = {
      default = { "lsp", "path", "snippets" },
    },

    snippets = { preset = "luasnip" },

    fuzzy = { implementation = "lua" }, -- fast Lua fuzzy matcher

    signature = { enabled = false }, -- optional: enable manually if needed
  },
}
