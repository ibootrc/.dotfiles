return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
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
            init_selection = "<C-s>", -- start selection
            node_incremental = "<C-s>", -- expand
            node_decremental = "<BS>", -- shrink
          },
        },
        textobjects = {
          select = { enable = true, lookahead = true },
          move = { enable = true, set_jumps = true },
        },
      }

      local ts_select = require "nvim-treesitter-textobjects.select"
      local ts_move = require "nvim-treesitter-textobjects.move"
      local ts_repeat = require "nvim-treesitter-textobjects.repeatable_move"

      local select_maps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      }
      for key, query in pairs(select_maps) do
        vim.keymap.set({ "x", "o" }, key, function()
          ts_select.select_textobject(query)
        end, { nowait = true, silent = true })
      end

      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        ts_move.goto_next_start "@function.outer"
      end)
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        ts_move.goto_previous_start "@function.outer"
      end)
      vim.keymap.set({ "n", "x", "o" }, ".", ts_repeat.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous)
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { expr = true })
    end,
  },
}
