return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "quarto", "rmd" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local p = require "archie.palette"

    require("render-markdown").setup {
      preset = "none",

      heading = {
        position = "inline",
        icons = {},
      },

      code = {
        enabled = true,
        render_modes = true,
        sign = false,
        language = false,
        width = "block",
        style = "minimal",
        highlight = "RenderMarkdownCode",
        highlight_inline = "RenderMarkdownCodeInline",
      },

      checkbox = {
        enabled = true,
        bullet = false,
        left_pad = 0,
        right_pad = 1,
        unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
        checked = { icon = "󰱒 ", highlight = "RenderMarkdownChecked" },
        custom = { todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" } },
      },

      quote = {
        enabled = true,
        icon = "│",
        repeat_linebreak = false,
      },

      callout = {
        note = { raw = "[!NOTE]", rendered = "Note", highlight = "RenderMarkdownInfo" },
        tip = { raw = "[!TIP]", rendered = "Tip", highlight = "RenderMarkdownSuccess" },
        warning = { raw = "[!WARNING]", rendered = "Warning", highlight = "RenderMarkdownWarn" },
        danger = { raw = "[!DANGER]", rendered = "Danger", highlight = "RenderMarkdownError" },
        info = { raw = "[!INFO]", rendered = "Info", highlight = "RenderMarkdownInfo" },
      },
    }

    -- Glass-style tmux-like heading colors
    local heading_bg = "#1b668f"
    local heading_fg = "#01D8DD"

    for i = 1, 6 do
      vim.api.nvim_set_hl(
        0,
        "RenderMarkdownH" .. i,
        { fg = heading_fg, bg = heading_bg, bold = true }
      )
      vim.api.nvim_set_hl(
        0,
        "RenderMarkdownH" .. i .. "Bg",
        { fg = heading_fg, bg = heading_bg, bold = true }
      )
    end

    -- Optional: conceal settings
    vim.opt.conceallevel = 2
    vim.opt.concealcursor = "nc"
  end,
}
