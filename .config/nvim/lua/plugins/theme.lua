return {
  {
    "ibootrc/archie.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("archie").setup {}
      vim.cmd "colorscheme archie"
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local p = require "archie.palette"

      -- We use p.bg_highlight (#34393E) to match your CursorLine exactly
      local cursorline_bg = p.bg_highlight

      local my_archie_theme = {
        normal = {
          a = { fg = p.white, bg = p.blue_deep, gui = "bold" },
          b = { fg = p.fg, bg = cursorline_bg }, -- Matches CursorLine
          c = { fg = p.fg, bg = cursorline_bg }, -- Matches CursorLine
        },
        insert = {
          a = { fg = p.white, bg = p.blue, gui = "bold" },
          b = { fg = p.fg, bg = cursorline_bg },
          c = { fg = p.fg, bg = cursorline_bg },
        },
        visual = {
          a = { fg = p.white, bg = p.orange, gui = "bold" },
          b = { fg = p.fg, bg = cursorline_bg },
          c = { fg = p.fg, bg = cursorline_bg },
        },
        replace = {
          a = { fg = p.white, bg = p.red, gui = "bold" },
          b = { fg = p.fg, bg = cursorline_bg },
          c = { fg = p.fg, bg = cursorline_bg },
        },
        command = {
          a = { fg = p.white, bg = p.purple, gui = "bold" },
          b = { fg = p.fg, bg = cursorline_bg },
          c = { fg = p.fg, bg = cursorline_bg },
        },
        inactive = {
          a = { fg = p.fg_alt, bg = p.none },
          b = { fg = p.fg_alt, bg = p.none },
          c = { fg = p.fg_alt, bg = p.none },
        },
      }

      require("lualine").setup {
        options = {
          icons_enabled = true,
          theme = my_archie_theme,
          component_separators = "",
          section_separators = "", -- Removed separators for a seamless "Bar" look
          globalstatus = true,
        },
      }
    end,
  },
}
