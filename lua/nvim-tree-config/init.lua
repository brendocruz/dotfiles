local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
	return
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
	diagnostics = {
		enable = true,
		show_on_dirs = true,
	},
	filters = {
		custom = {},
		dotfiles = true,
		exclude = {},
	},
	open_on_setup = false,
	renderer = {
		add_trailing = true,
		group_empty = false,
		highlight_opened_files = 'all',
		indent_width = 2,
		root_folder_modifier = ':t',
	},
	sort_by = 'case_sensitive',
	view = {
		adaptive_size = true,
		centralize_selection = true,
		float = {
			enable = true,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = 'editor',
				border = 'none',
				width = 30,
				height = 30,
				row = 0,
				col = 0,
			},
		},
		hide_root_folder = false,
		number = false,
		preserve_window_proportions = false,
		relativenumber = false,
		side = 'left',
		signcolumn = 'yes',
	},
})


local opts = { noremap = true, silent = true }
-- NvimTree
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>f', ':NvimTreeFocus<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>c', ':NvimTreeCollapse<CR>', opts)
