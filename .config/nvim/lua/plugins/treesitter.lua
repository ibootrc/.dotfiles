return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
      },
    },

    config = function()
      local ts = require("nvim-treesitter")

      ts.install({
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "bash",
        "json",
        "python",
        "rust",
        "c",
        "cpp",
        "typescript",
        "tsx",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup(
          "UserTreesitter",
          { clear = true }
        ),

        callback = function(args)
          local buf = args.buf
          local lang = vim.treesitter.language.get_lang(
            vim.bo[buf].filetype
          )

          if not lang then
            return
          end

          if not vim.treesitter.language.add(lang) then
            return
          end

          vim.treesitter.start(buf)

          if vim.treesitter.query.get(lang, "indents") then
            vim.bo[buf].indentexpr =
              "v:lua.require'nvim-treesitter'.indentexpr()"
          end

        end,
      })

      --------------------------------------------------------------------
      -- Textobjects
      --------------------------------------------------------------------

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")

      vim.keymap.set({ "x", "o" }, "af", function()
        select.select_textobject("@function.outer")
      end)

      vim.keymap.set({ "x", "o" }, "if", function()
        select.select_textobject("@function.inner")
      end)

      vim.keymap.set({ "x", "o" }, "ac", function()
        select.select_textobject("@class.outer")
      end)

      vim.keymap.set({ "x", "o" }, "ic", function()
        select.select_textobject("@class.inner")
      end)

      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        move.goto_next_start("@function.outer")
      end)

      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        move.goto_previous_start("@function.outer")
      end)
    end,
  },
}
