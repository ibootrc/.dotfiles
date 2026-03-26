return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },

  opts = {
    code = {
      enabled = true,

      -- Layout only (no theming)
      width = "block",
      min_width = 60,
      left_pad = 2,
      right_pad = 2,

      -- Keep structure, remove visual styling overrides
      border = "rounded",

      -- Keep UX features
      language_icon = true,
      language_name = true,
      sign = false,
    },

    heading = {
      enabled = true,
      sign = false,
      icons = { "󰎤 ", "󰎧 ", "󰎪 ", "󰎭 ", "󰎱 ", "󰎳 " },
      width = "block",
    },

    checkbox = {
      enabled = false,
    },

    -- Performance safeguards
    render_modes = true,
    max_file_size = 200 * 1024,
  },

  config = function(_, opts)
    local rm = require "render-markdown"
    rm.setup(opts)

    -- Auto-disable on large files
    vim.api.nvim_create_autocmd("BufReadPre", {
      callback = function(args)
        local size = vim.fn.getfsize(args.file)
        if size > 200 * 1024 then
          rm.set(false)
        end
      end,
    })
  end,
}
