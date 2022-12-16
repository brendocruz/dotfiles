vim.g.mapleader = ' '

local opts = { noremap = true, silent = true }
-- NvimTree
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f', ':NvimTreeFocus<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>c', ':NvimTreeCollapse<CR>', opts)

vim.api.nvim_set_keymap('n', '<leader>z', ':lua vim.lsp.buf.formatting_sync()<CR>', opts)
