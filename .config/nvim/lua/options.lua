-- Leader key
vim.g.mapleader = " "
-- General options
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.clipboard:append({ "unnamed", "unnamedplus" })
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
vim.opt.breakindent = true
vim.opt.signcolumn = 'yes'
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- Highlight settingsvim.cmd([[highlight LineNr guibg=bg]])

vim.cmd([[
augroup CustomCursorLineHighlight
    autocmd!
    autocmd VimEnter * highlight CursorLine guifg=#A8D8E6 guibg=#4a4a4a
augroup END
]])

-- UI and Visual Customizations
-- Customize the appearance of fold column, vertical splits, and fill characters

vim.opt.foldcolumn = "0"
vim.cmd([[highlight FoldColumn guibg=bg]])
vim.cmd([[highlight VertSplit guifg=bg guibg=bg]])
vim.opt.fillchars = {
    vert = "|", -- Simple vertical line
    fold = "-", -- Simple fold separator
    eob = "~",  -- Keep classic end-of-buffer markers
    diff = "-", -- Horizontal line for diffs
}



-- Key mappings
vim.keymap.set("i", "jj", "<Esc>", { noremap = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Help pages in vertical splits
vim.api.nvim_create_autocmd("BufWinEnter", {
    group = vim.api.nvim_create_augroup("help_window_right", {}),
    pattern = { "*.txt" },
    callback = function()
        if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
    end
})


-- Noice
vim.keymap.set("n", "<leader>mm", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss Noice Message" })

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

-- Set cursor line number color 
vim.api.nvim_create_autocmd("BufWinEnter", {
    callback = function()
        vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#A8D8E6', bold = true })
    end
})

-- Adjust number width and sign column for help pages
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        vim.wo.number = true            -- Enable line numbers for help files
        vim.wo.relativenumber = true   -- Optional: disable relative numbers for help files
        vim.wo.numberwidth = 1          -- Reduce number column width
        vim.wo.signcolumn = "no"       -- Remove the sign column in help files
    end,
})

-- Disable the right-click popup menu
vim.api.nvim_set_keymap('n', '<RightMouse>', '<NOP>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<RightMouse>', '<NOP>', { noremap = true, silent = true })

