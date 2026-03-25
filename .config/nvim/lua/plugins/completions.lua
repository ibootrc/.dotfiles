return {
  -- blink-cmp config
  {
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
  },
  --- supermaven config

  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup {
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-k>",
        },
        ignore_filetypes = { cpp = true }, -- or { "cpp", }
        color = {
          suggestion_color = "#C5663F",
          style = "bold", -- or "underline"
          cterm = 244,
        },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = false, -- disables inline completion for use with cmp
        disable_keymaps = false, -- disables built-in keymaps for more manual control
        condition = function()
          return false
        end,
      }
    end,
  },
}
