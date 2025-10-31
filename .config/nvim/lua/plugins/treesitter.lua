return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require "nvim-treesitter.configs"
      config.setup {
        modules = {},
        sync_install = false,
        auto_install = true,
        ensure_installed = {}, -- satisfies LSP
        ignore_install = {}, -- optional
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
}
