vim.g.mapleader = ' '
local opts = { noremap = true, silent = true }

-- go half page down and centralize the cursor
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', opts)

-- go half page up and centralize the cursor
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', opts)

-- go to next search result and centralize the cursor
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opts)

-- go to previous search result and centralize the cursor
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opts)

-- set a mark in position of the cursor and
-- go to the beginning of the buffer
vim.api.nvim_set_keymap('n', 'gg', 'msgg', opts)

-- set a mark in position of the cursor and
-- go to the end of the buffer and centralize the cursor
vim.api.nvim_set_keymap('n', 'G', 'Gzz', opts)

-- go to normal mode in terminal mode pressing Esc
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', opts)

-- delete next character
vim.api.nvim_set_keymap('i', '<A-x>', '<Esc>xpXa', opts)
vim.api.nvim_set_keymap('n', '<A-x>', 'xpX<Esc>', opts)

-- move using hjkl in insert mode
vim.api.nvim_set_keymap('i', '<C-h>', '<Left>', opts)
vim.api.nvim_set_keymap('i', '<C-j>', '<Down>', opts)
vim.api.nvim_set_keymap('i', '<C-k>', '<Up>', opts)
vim.api.nvim_set_keymap('i', '<C-l>', '<Right>', opts)
