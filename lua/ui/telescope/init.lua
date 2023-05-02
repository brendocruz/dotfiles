local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
	return
end

telescope.setup({
	defaults = {
		prompt_prefix = '$ ',
		file_ignore_patterns = {
			'node_modules', 'dist',
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
		}
	}
})

telescope.load_extension('fzf')


-- Telescope mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>b', builtin.buffers, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
