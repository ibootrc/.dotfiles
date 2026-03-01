return {
  -- Twilight.nvim
  {
    "folke/twilight.nvim",
    lazy = false,
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.7,
          color = { "Normal" },
        },
        context = 0,
        expand = { "function", "method", "table", "if_statement" },
        treesitter = true,
      }
    end,
  },

  -- Flash.nvim
  {
    "folke/flash.nvim",
    lazy = false,
    dependencies = { "folke/twilight.nvim" },
    opts = {
      highlight = {
        backdrop = true,
        matches = "Search",
        priority = 10,
      },
      modes = {
        char = { enabled = true },
        search = { enabled = true },
        treesitter = { enabled = false },
      },
      search = { incremental = true, mode = "current_line" },
      jump = { autojump = true },
    },
    config = function(_, opts)
      local flash = require "flash"
      local twilight = require "twilight"

      flash.setup(opts)

      local function flash_with_spotlight(fn)
        twilight.enable()
        fn()
        twilight.disable()
      end

      local mappings = {
        { "s", flash.jump, "Flash" },
        { "S", flash.treesitter, "Flash Treesitter" },
        { "r", flash.remote, "Remote Flash" },
        { "rr", flash.treesitter_search, "Treesitter Search" },
        { "<c-s>", flash.toggle, "Toggle Flash Search" },
      }

      for _, k in ipairs(mappings) do
        vim.keymap.set({ "n", "x", "o" }, k[1], function()
          flash_with_spotlight(k[2])
        end, { desc = k[3] .. " with Spotlight", silent = true })
      end
    end,
  },
}
