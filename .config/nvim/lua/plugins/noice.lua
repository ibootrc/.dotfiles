return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    views = {
      cmdline_popup = {
        position = {
          row = "50%",  -- Center vertically
          col = "50%",  -- Center horizontally
        },
        size = {
          width = "90%",  -- Set the width to 90% of the screen
          height = "auto",  -- Let height adjust automatically
        },
      },
    },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",  -- Required for Noice
    "rcarriga/nvim-notify",  -- Optional, for notifications
  },
}
