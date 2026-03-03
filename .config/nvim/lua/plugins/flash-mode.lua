return {
  {
    "folke/flash.nvim",
    keys = { "s", "S", "r", "rr", "<c-s>" },
    opts = {
      highlight = {
        backdrop = true,
        matches = "IncSearch",
        priority = 5000,
      },
      modes = {
        char = { enabled = true, jump_labels = false },
        search = { enabled = true },
        treesitter = { enabled = false },
      },
      search = {
        incremental = true,
        mode = "current_line",
      },
      jump = {
        autojump = false,
      },
      max_length = 5000,
    },
    config = function(_, opts)
      local flash = require "flash"
      flash.setup(opts)

      -- Make Flash labels more readable without changing other highlights
      vim.api.nvim_set_hl(0, "FlashLabel", {
        fg = "#ffffff", -- bright color for labels
        bg = nil, -- keep background as-is
        bold = true,
        underline = false,
        reverse = false,
        italic = false,
      })

      local mappings = {
        { "s", flash.jump, "Flash" },
        { "S", flash.treesitter, "Flash Treesitter" },
        { "r", flash.remote, "Remote Flash" },
        { "rr", flash.treesitter_search, "Treesitter Search" },
        { "<c-s>", flash.toggle, "Toggle Flash Search" },
      }

      for _, m in ipairs(mappings) do
        vim.keymap.set({ "n", "x", "o" }, m[1], m[2], {
          desc = m[3],
          silent = true,
        })
      end
    end,
  },
}
