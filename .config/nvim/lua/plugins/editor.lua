return {
  -- Telescope config
  {
    "nvim-telescope/telescope.nvim",
    priority = 1000,
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-file-browser.nvim",
      "nvim-tree/nvim-web-devicons",
      { "debugloop/telescope-undo.nvim" },
    },
    keys = {
      {
        ";f",
        function()
          require("telescope.builtin").find_files {
            no_ignore = false,
            hidden = true,
            file_ignore_patterns = { "node_modules/*" },
          }
        end,
        desc = "Find files",
      },
      {
        ";r",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Live grep",
      },
      {
        "\\\\",
        function()
          require("telescope.builtin").buffers()
        end,
        desc = "List buffers",
      },
      {
        ";;",
        function()
          require("telescope.builtin").resume()
        end,
        desc = "Resume last picker",
      },
      {
        ";e",
        function()
          require("telescope.builtin").diagnostics()
        end,
        desc = "Diagnostics",
      },
      {
        ";s",
        function()
          require("telescope.builtin").treesitter()
        end,
        desc = "Treesitter symbols",
      },
      {
        ";c",
        function()
          require("telescope.builtin").current_buffer_fuzzy_find()
        end,
        desc = "Current buffer search",
      },
      {
        ";a",
        function()
          local telescope = require "telescope"
          local function telescope_buffer_dir()
            return vim.fn.expand "%:p:h"
          end
          telescope.extensions.file_browser.file_browser {
            path = "%:p:h",
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = "normal",
            layout_config = {
              height = 30,
            },
          }
        end,
        desc = "File Browser",
      },
      {
        ";w",
        function()
          require("telescope").extensions.undo.undo()
        end,
        desc = "Undo history",
      },
    },
    config = function(_, opts)
      local telescope = require "telescope"
      local actions = require "telescope.actions"
      local fb_actions = telescope.extensions.file_browser.actions

      -- Defaults
      opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
        wrap_results = true,
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            width = 0.90, -- High-performance HUD width
            preview_width = 0.50, -- Big preview for code
          },
          -- This keeps your other themes (ivy/dropdown) from crashing
          height = 0.60,
        },
        sorting_strategy = "ascending",
        winblend = 0,
        mappings = { n = {} },
      })
      -- Pickers
      opts.pickers = {
        diagnostics = {
          theme = "ivy",
          initial_mode = "normal",
          layout_config = {
            preview_cutoff = 9999,
          },
        },
        buffers = {
          show_all_buffers = true,
          sort_mru = true,
          sort_lastused = true,
          ignore_current_buffer = false,
          initial_mode = "normal",
          show_buffer_numbers = true,
          mappings = { n = { ["dd"] = actions.delete_buffer } },
        },
      }

      -- Extensions
      opts.extensions = {
        file_browser = {
          theme = "dropdown",
          hijack_netrw = true,
          mappings = {
            n = {
              ["N"] = fb_actions.create,
              ["h"] = fb_actions.goto_parent_dir,
              ["<C-u>"] = function(p)
                for _ = 1, 10 do
                  actions.move_selection_previous(p)
                end
              end,
              ["<C-d>"] = function(p)
                for _ = 1, 10 do
                  actions.move_selection_next(p)
                end
              end,
            },
          },
        },
        undo = {
          initial_mode = "normal",
          mappings = {
            n = {
              ["<CR>"] = require("telescope-undo.actions").restore,
              ["y"] = require("telescope-undo.actions").yank_additions,
              ["Y"] = require("telescope-undo.actions").yank_deletions,
            },
          },
        },
      }

      telescope.setup(opts)
      telescope.load_extension "fzf"
      telescope.load_extension "file_browser"
      telescope.load_extension "undo"

      -- Highlights inside config
      --  vim.api.nvim_set_hl(0, "TelescopeSelection", { fg = "#A8D8E6", bg = "#4a4a4a", bold = true })
      --  vim.api.nvim_set_hl(0, "TelescopeMatching", { fg = "#FFB86C" })
      --  vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = "#56B6C2" })
    end,
  },

  -- Autopairs config
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require "nvim-autopairs"

      npairs.setup {
        check_ts = true, -- use treesitter to check for pairs
        ts_config = {
          lua = { "string" }, -- don't add pairs in lua string treesitter nodes
          javascript = { "template_string" },
        },
        enable_moveright = false,
        -- don't add pairs if it's already close
        enable_check_bracket_line = true,
        -- check treesitter for the cursor position
        map_cr = true,
      }

      -- Add a specific rule to ensure typing '[' always results in '[|]'
      local Rule = require "nvim-autopairs.rule"
      npairs.add_rules {
        Rule("[ ", " ]")
          :with_pair(function()
            return false
          end)
          :with_move(function(opts)
            return opts.prev_char:match ".%]" ~= nil
          end)
          :use_key "]",
      }
    end,
  },
  -- Colorizer
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup {
        "*",
        css = { mode = "foreground" },
        html = { mode = "foreground" },
        javascript = { mode = "foreground" },
      }
    end,
  },

  -- Indent-blankline config
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead", "InsertEnter", "BufNewFile" },
    lazy = true,
    opts = { indent = { char = "|", tab_char = "|" } },
    main = "ibl",
  },

  -- Notify config
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        render = "compact",
        stages = "fade_in_slide_out",
        timeout = 3000,
        background_colour = "#1e1e1e",
      }
      vim.notify = require "notify"
    end,
  },

  -- Noice config with blink.cmp <CR> commit in cmdline
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify", "saghen/blink.cmp" },
    opts = {
      views = {
        cmdline_popup = {
          position = { row = "45%", col = "50%" },
          size = { width = "55%", height = "auto" },
          lsp_doc_border = true,
        },
      },
      presets = { command_palette = true, bottom_search = true },
      notify = { enabled = true },
      -- ADD THIS LINE TO FIX THE FZF ERROR:
      --commands = { history = { view = "split" } },
    },
  },

  -- null-ls config
  {
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require "null-ls"
      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.shfmt,
        },
        on_attach = function(client, bufnr)
          if client.supports_method "textDocument/formatting" then
            local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })
            vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format {
                  bufnr = bufnr,
                  filter = function(f)
                    return f.name == "null-ls"
                  end,
                  async = false,
                }
              end,
            })
          end
        end,
      }
    end,
  },
}
