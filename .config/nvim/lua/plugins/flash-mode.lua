return {
  "folke/flash.nvim",
  -- Performance: 'keys' handles lazy-loading perfectly
  keys = {
    {
      "s",
      mode = { "n", "x", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
      nowait = true,
    },
    {
      "S",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter()
      end,
      desc = "Flash Treesitter",
      nowait = true,
    },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    -- Optimization: Use 'R' instead of 'rr' to avoid wait-time for the second 'r'
    {
      "R",
      mode = { "n", "x", "o" },
      function()
        require("flash").treesitter_search()
      end,
      desc = "Treesitter Search",
    },
  },
  opts = {
    highlight = { backdrop = true, matches = "IncSearch", priority = 5000 },
    modes = {
      char = { enabled = true, jump_labels = false },
      search = { enabled = true },
      treesitter = { enabled = false },
    },
    search = { incremental = true, mode = "current_line" },
    jump = { autojump = false },
  },
  config = function(_, opts)
    require("flash").setup(opts)
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#EBCB8B", bold = true })
  end,
}
