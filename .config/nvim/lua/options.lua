-- Leader key
vim.g.mapleader = " "

-- General options
vim.opt.timeoutlen = 200
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard = "unnamedplus"
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.cursorline = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.scroll = 10
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

-- UI and Visual Customizations (Untouched as requested)
vim.opt.foldcolumn = "0"
vim.cmd [[highlight FoldColumn guibg=bbg]]
vim.cmd [[highlight VertSplit guifg=bg guibg=bbg]]
vim.opt.fillchars = {
  vert = "|",
  fold = "-",
  eob = " ",
  diff = "-",
}

-- THE "NO-HEADACHE" SNAP-TO-TOP MAPPINGS

-- 1. Visual Mode (Selection starts, snaps start of block to top)
local v_objects = { "i{", "i[", "i(" }
for _, obj in ipairs(v_objects) do
  vim.keymap.set("v", obj, obj .. "oztvo", { noremap = true, silent = true })
end

-- 2. Operator-Pending (Yank/Delete inside/around snaps to top)
local o_objects = { "i{", "a{", "i[", "a[" }
for _, obj in ipairs(o_objects) do
  vim.keymap.set("o", obj, obj .. "zt", { noremap = true, silent = true })
end

-- 3. Navigation & Search (Eyes always stay on Line 1)
vim.keymap.set("n", "<C-d>", "<C-d>zt", { desc = "Scroll down to top" })
vim.keymap.set("n", "<C-u>", "<C-u>zt", { desc = "Scroll up to top" })
vim.keymap.set("n", "n", "nzt", { desc = "Next result at top" })
vim.keymap.set("n", "N", "Nzt", { desc = "Prev result at top" })
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zt", { desc = "Next error at top" })
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zt", { desc = "Prev error at top" })

-- General Keymaps
vim.keymap.set("n", "s", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd "so"
  print "Config Reloaded!"
end)

-- Window Navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus lower" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus upper" })
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Autocommands
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Help Window Settings
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "help",
  callback = function()
    if vim.bo.filetype == "help" then
      vim.cmd "wincmd L"
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  callback = function()
    vim.wo.number = true
    vim.wo.relativenumber = false
    vim.wo.signcolumn = "no"
  end,
})

-- Disable Mouse
vim.keymap.set({ "n", "v" }, "<RightMouse>", "<NOP>")
