return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- Performance: Load only when opening a file
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
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            node_decremental = "<BS>",
          },
        },
        textobjects = {
          select = { enable = true, lookahead = true },
          move = { enable = true, set_jumps = true },
        },
      }

      -- Cache modules for speed
      local ts_select = require "nvim-treesitter-textobjects.select"
      local ts_move = require "nvim-treesitter-textobjects.move"
      local ts_repeat = require "nvim-treesitter-textobjects.repeatable_move"

      -- 1. SELECTION MAPPINGS (Visual 'x' and Operator-pending 'o')
      -- Use nowait = true so 'af' and 'if' bypass the 200ms timeout lag
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

      -- 2. MOVE MAPPINGS (Optimized for 200ms timeout)
      -- Single character suffixes (f, c) are faster than double-tapping (]], [[)
      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        ts_move.goto_next_start "@function.outer"
      end)
      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        ts_move.goto_previous_start "@function.outer"
      end)
      vim.keymap.set({ "n", "x", "o" }, "]c", function()
        ts_move.goto_next_start "@class.outer"
      end)
      vim.keymap.set({ "n", "x", "o" }, "[c", function()
        ts_move.goto_previous_start "@class.outer"
      end)

      -- 3. REPEATABLE MOVEMENTS
      -- After one jump, spam ; or , to keep moving
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat.repeat_last_move_previous)

      -- Sync standard f/t movements with the same ;/, repeat logic
      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat.builtin_T_expr, { expr = true })
    end,
  },
}
