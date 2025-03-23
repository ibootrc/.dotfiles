return {
  -- Load nvim-notify before Noice
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup({
        render = "compact", -- Compact style
        stages = "fade_in_slide_out", -- Animation
        timeout = 3000,
        background_colour = "#1e1e1e",
      })
      vim.notify = require("notify") -- Set as default notify function
    end,
  },

  -- Now load Noice
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = {
      views = {
        cmdline_popup = {
          position = { row = "50%", col = "50%" },
          size = { width = "90%", height = "auto" },
        },
      },
      presets = {
        command_palette = true,
        bottom_search = true,
      },
      notify = {
        enabled = true, -- Ensure Noice notifications are active
      },
    },
    config = function()
      require("noice").setup()
    end,
  },
}
