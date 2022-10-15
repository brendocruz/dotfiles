local status_ok, nvim_tree = pcall(require, 'nvim-tree')
if not status_ok then
	return
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
	open_on_setup = true,

	sort_by = 'case_sensitive',
	view = {
		adaptive_size = false,
		preserve_window_proportions = false,
		number = false,
		relativenumber = false,
		signcolumn = 'yes',
		float = {
			enable = true,
			quit_on_focus_loss = true,
			open_win_config = {
				relative = 'editor',
				border = 'none',
				width = 30,
				height = 30,
				row = 1,
				col = 1,
			}
		}
	},
	renderer = {
		group_empty = true,
		highlight_opened_files = 'all',
		root_folder_modifier = ':p',
		indent_width = 3
	},
	filters = {
		dotfiles = true,
	},
	diagnostics = {
		enable = true,
		show_on_dirs = true
	}
})
