local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true}
map('n', '<F10>',  ':TagbarToggle<CR>', opts)

vim.cmd([[
	let g:tagbar_autoclose = 1
	let g:tagbar_autofocus = 1
	let g:tagbar_sort = 0
	let g:tagbar_compact = 2
	let g:tagbar_show_data_type = 1
]])
