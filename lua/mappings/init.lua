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

-- go to the end of the buffer and centralize the cursor
vim.api.nvim_set_keymap('n', 'G', 'Gzz', opts)
