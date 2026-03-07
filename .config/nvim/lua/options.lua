-- Leader key
vim.g.mapleader = " "
-- General options
vim.opt.timeoutlen = 200
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard:append { "unnamed", "unnamedplus" }
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.scrolloff = 10
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.breakindent = false
vim.opt.signcolumn = "yes"
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.wildignore:append { "*/node_modules/**" }
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.opt.undofile = true
vim.keymap.set("n", "s", "<Nop>", { noremap = true, silent = true })

-- UI and Visual Customizations
-- Customize the appearance of fold column, vertical splits, and fill characters
vim.opt.foldcolumn = "0"
vim.cmd [[highlight FoldColumn guibg=bbg]]
vim.cmd [[highlight VertSplit guifg=bg guibg=bbg]]
vim.opt.fillchars = {
  vert = "|", -- Simple vertical line
  fold = "-", -- Simple fold separator
  eob = " ", -- Fix: must be a single space, not empty
  diff = "-", -- Horizontal line for diffs
}
-- Key mappings
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-p>", "<cmd>lprev<CR>zz")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd "so"
  print "Config Reloadeed!"
end)

-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Move help windows to a vertical split on the right
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("HelpWindowRight", {}),
  pattern = "help",
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd "wincmd L"
    end
  end,
})
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Adjust number width and sign column for help pages
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    vim.wo.number = true -- Enable line numbers for help files
    vim.wo.relativenumber = false -- Disable relative numbers for help files
    vim.wo.numberwidth = 2 -- Reduce number column width
    vim.wo.signcolumn = "no" -- Remove sign column
  end,
})
-- Disable the right-click popup menu
vim.api.nvim_set_keymap("n", "<RightMouse>", "<NOP>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<RightMouse>", "<NOP>", { noremap = true, silent = true })
