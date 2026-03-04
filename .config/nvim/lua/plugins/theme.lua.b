return {

 { "ibootrc/viel.nvim",
  priority = 1000,
  config = function()
    local viel = require "viel"
    -- Ensure setup is called to set the transparency flag
    viel.setup { transparent = true }
    vim.cmd [[colorscheme viel]]
  end,
},
	 -- Custom lualine theme
      local lualine_theme = {
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
          theme = lualine_theme,
          component_separators = "",
          section_separators = "",
        },
      }
    end,
  },

}

