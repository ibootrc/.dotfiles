return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "quarto", "rmd" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  config = function()
    require("render-markdown").setup {
      preset = "obsidian",
      heading = {
        icons = { "   ", "   ", "   ", "   ", "   ", "   " },
        position = "overlay",
        -- Disable heading background highlights by setting them to 'none'
        backgrounds = { "none", "none", "none", "none", "none", "none" },
      },
      code = {
        -- Remove the solid background from code blocks
        highlight = "Normal",
        -- If using 'full' width, this prevents the block from painting a background
        style = "language",
      },
    }

    -- Force-clear the specific background highlights via Neovim API
    local groups = {
      "RenderMarkdownH1Bg",
      "RenderMarkdownH2Bg",
      "RenderMarkdownH3Bg",
      "RenderMarkdownH4Bg",
      "RenderMarkdownH5Bg",
      "RenderMarkdownH6Bg",
      "RenderMarkdownCode",
      "RenderMarkdownCodeInline",
    }
    for _, group in ipairs(groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none", force = true })
    end
  end,
}
