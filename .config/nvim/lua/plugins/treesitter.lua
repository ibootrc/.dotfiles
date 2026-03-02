-- lua/plugins/treesitter.lua
return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        lazy = false,
        init = function()
          vim.g.no_plugin_maps = true -- disable built-in mappings
        end,
      },
    },
    config = function()
      -- Treesitter core
      require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "lua",
          "javascript",
          "typescript",
          "tsx",
          "html",
          "css",
          "json",
          "yaml",
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            node_decremental = "<BS>",
            scope_incremental = false,
          },
        },
        textobjects = {
          select = { enable = true, lookahead = false, include_surrounding_whitespace = false },
          move = { enable = true, set_jumps = true },
        },
      }

      -- Selection keymaps (explicit)
      local ts_select = require "nvim-treesitter-textobjects.select"
      vim.keymap.set({ "x", "o" }, "af", function()
        ts_select.select_textobject("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "if", function()
        ts_select.select_textobject("@function.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ac", function()
        ts_select.select_textobject("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "ic", function()
        ts_select.select_textobject("@class.inner", "textobjects")
      end)
      vim.keymap.set({ "x", "o" }, "as", function()
        ts_select.select_textobject("@local.scope", "locals")
      end)

      -- Move keymaps (minimal)
      local ts_move = require "nvim-treesitter-textobjects.move"
      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        ts_move.goto_next_start("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        ts_move.goto_previous_start("@function.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "][", function()
        ts_move.goto_next_start("@class.outer", "textobjects")
      end)
      vim.keymap.set({ "n", "x", "o" }, "[[", function()
        ts_move.goto_previous_start("@class.outer", "textobjects")
      end)

      -- Repeatable movements
      local ts_repeat = require "nvim-treesitter-textobjects.repeatable_move"
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous)
    end,
  },
}
