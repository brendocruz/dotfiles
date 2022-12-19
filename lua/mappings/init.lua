vim.g.mapleader = ' '
local opts = { noremap = true, silent = true }

-- go half page up or down and centralize the cursor in the middle of the screen
vim.api.nvim_set_keymap('n', '<C-d>', '<C-d>zz', opts)
vim.api.nvim_set_keymap('n', '<C-u>', '<C-u>zz', opts)

-- go to next or previous occurrence of a search and centralize the cursor
-- in the middle of the screen
vim.api.nvim_set_keymap('n', 'n', 'nzzzv', opts)
vim.api.nvim_set_keymap('n', 'N', 'Nzzzv', opts)

-- vim.api.nvim_set_keymap('n', '<leader>z', ':lua vim.lsp.buf.formatting_sync()<CR>', opts)
