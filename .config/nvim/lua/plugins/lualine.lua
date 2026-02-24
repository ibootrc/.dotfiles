return {
  "nvim-lualine/lualine.nvim",
  config = function()
    local lualine = require "lualine"

    -- Minimal palette (only used colors)
    local palette = {
      bg0 = "NONE",
      bg1 = "NONE",
      none = "NONE",

      fg = "#C9BEC2",
      fgline = "#E4F0FB",

      grey = "#5C5457",
      light_grey = "#87757C",

      blue = "#1b668f",
      orange = "#C5663F",
      red = "#D17B9A",
      purple = "#7060eb",
    }

    -- Custom lualine theme
    local vith_lualine = {
      normal = {
        a = { fg = palette.bg0, bg = palette.grey, gui = "bold" },
        b = { fg = palette.fg, bg = palette.bg1 },
        c = { fg = palette.grey, bg = palette.none },
      },
      insert = {
        a = { fg = palette.fgline, bg = palette.blue, gui = "bold" },
        b = { fg = palette.fg, bg = palette.bg1 },
        c = { fg = palette.grey, bg = palette.none },
      },
      visual = {
        a = { fg = palette.bg0, bg = palette.orange, gui = "bold" },
        b = { fg = palette.fg, bg = palette.bg1 },
        c = { fg = palette.grey, bg = palette.none },
      },
      replace = {
        a = { fg = palette.bg0, bg = palette.red, gui = "bold" },
        b = { fg = palette.fg, bg = palette.bg1 },
        c = { fg = palette.grey, bg = palette.none },
      },
      command = {
        a = { fg = palette.bg0, bg = palette.purple, gui = "bold" },
        b = { fg = palette.fg, bg = palette.bg1 },
        c = { fg = palette.grey, bg = palette.none },
      },
      inactive = {
        a = { fg = palette.light_grey, bg = palette.bg1, gui = "bold" },
        b = { fg = palette.light_grey, bg = palette.bg1 },
        c = { fg = palette.light_grey, bg = palette.none },
      },
    }

    lualine.setup {
      options = {
        icons_enabled = true,
        theme = vith_lualine,
        component_separators = "",
        section_separators = "",
      },
    }
  end,
}
