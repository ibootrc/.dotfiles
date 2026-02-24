return {
  "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function()
    -- Enable true colors
    vim.o.termguicolors = true

    require("everforest").setup {
      transparent_background_level = 1,

      -- 1. Neutralize green-tinted background
      colours_override = function(palette)
        palette.bg0 = "#1f2329"
        palette.bg1 = "#262b31"
        palette.bg2 = "#2c3238"
        palette.bg_green = palette.bg0
      end,

      -- 2. Customize highlights
      on_highlights = function(hl, palette)
        -- Search highlights
        hl.Search = { bg = palette.bg_visual, fg = palette.fg }
        hl.IncSearch = { bg = palette.bg_visual, fg = palette.fg }
        hl.CurSearch = { bg = palette.bg_visual, fg = palette.fg }
        hl.Substitute = { bg = palette.bg_visual, fg = palette.fg }

        -- Cursor line
        hl.CursorLine = { bg = "#5C5457" }

        -- Line numbers
        hl.LineNr = { fg = palette.grey1, bg = "#1f2329" }
        hl.CursorLineNr = { fg = palette.fg, bg = "#5C5457", bold = true }

        -- Floating windows
        hl.NormalFloat = { bg = "#5C5457", fg = palette.fg }
        hl.FloatBorder = { bg = "#5C5457", fg = palette.grey1 }
        hl.FloatTitle = { bg = "#5C5457", fg = palette.fg }

        -- Popup menu / completion menu
        hl.Pmenu = { bg = "NONE", fg = palette.fg } -- transparent base
        hl.PmenuSbar = { bg = "NONE" }
        hl.PmenuThumb = { bg = "NONE" }
        hl.PmenuSel = { bg = palette.bg_visual, fg = palette.fg } -- reddish selection

        -- blink.nvim plugin highlights
        hl.BlinkCmpMenu = { bg = "NONE", fg = palette.fg } -- transparent base
        hl.BlinkCmpMenuBorder = { bg = "NONE", fg = palette.grey1 }

        -- Optimized completion docs: muted reddish background + subtle floating effect
        hl.BlinkCmpDoc = { bg = "#7f3f3f", fg = palette.fg, blend = 35 } -- muted reddish
        hl.BlinkCmpDocBorder = { bg = "#7f3f3f", fg = "#3a3f46" } -- darker border
        hl.BlinkCmpSel = { bg = palette.bg_visual, fg = palette.fg } -- selection inside docs
      end,
    }

    -- Apply colorscheme
    vim.cmd [[colorscheme everforest]]
  end,
}
