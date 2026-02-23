return {
  "norcalli/nvim-colorizer.lua",
  config = function()
    require("colorizer").setup {
      "*", -- all filetypes
      css = { mode = "foreground" },
      html = { mode = "foreground" },
      javascript = { mode = "foreground" },
    }
  end,
}
