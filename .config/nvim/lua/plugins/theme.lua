return {
  "ibootrc/vith.nvim",
  lazy = false,
  priority = 1000,
  init = function()
    -- Enable truecolor first
    vim.opt.termguicolors = true
    require("vith").setup()
  end,
}
