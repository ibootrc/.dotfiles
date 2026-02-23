return {
  "sainnhe/everforest",
  lazy = false,
  priority = 1000,
  config = function()
    vim.opt.termguicolors = true
    vim.o.background = "dark"
    vim.o.guicursor = "a:block"
    vim.g.everforest_cursor = "red"
    vim.g.everforest_sign_column_background = "linenr"
    vim.g.everforest_transparent_background = 2
    vim.g.everforest_background = "soft"
    vim.g.everforest_better_performance = 1
    vim.g.lightline = { colorscheme = "everforest" }
    vim.cmd.colorscheme "everforest"
  end,
}
