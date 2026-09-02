local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- 1. Load general options
require "options"

-- 2. Setup Lazy with Premium UI & Performance optimizations
require("lazy").setup("plugins", {
  install = {
    -- This forces Lazy to attempt to load Archie specifically for the UI
    colorscheme = { "archie", "habamax" },
  },
  ui = {
    -- Glass Look: No background dimming
    backdrop = 100,
    border = "rounded",
    icons = {
      loaded = "●",
      not_loaded = "○",
      handler = "⚙",
    },
  },
  performance = {
    cache = { enabled = true },
    reset_packpath = true,
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
