local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
	return
end

local fb_actions = telescope.extensions.file_browser.actions
local actions = require "telescope.actions"


telescope.setup({
	defaults = {
		prompt_prefix = '$ ',
		file_ignore_patterns = {
			'node_modules', 'dist', 'node_modules/**/*'
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = 'smart_case',
		},
		file_browser = {
			theme = 'ivy',
			hijack_netrw = true,
			grouped = true,
			initial_mode = 'normal',
			hidden = {
				file_browser = true,
				folder_browser = true,
			},
			mappings = {
				['i'] = {
					['<C-h>'] = fb_actions.goto_parent_dir,
					['<C-l>'] = actions.select_default,
					['<C-H>'] = fb_actions.toggle_hidden,
				},
				['n'] = {
					['c'] = false,
					['cc'] = fb_actions.create,
					['d'] = false,
					['dd'] = fb_actions.remove,
					['h'] = fb_actions.goto_parent_dir,
					['l'] = actions.select_default,
					['H'] = fb_actions.toggle_hidden,
				},
			}
		},
	},
	pickers = {
		find_files = {
		},
		current_buffer_fuzzy_find = {
			sorting_strategy = 'ascending',
		},
	},
})



-- Load Extensions
telescope.load_extension('fzf')
telescope.load_extension('file_browser')
telescope.load_extension('harpoon')




-- Telescope mappings
local builtin = require('telescope.builtin')
local opts = { noremap = true, silent = true }
local term = require('harpoon.term')
local num_terms = 3

vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
vim.keymap.set('n', '<leader>b', builtin.buffers, opts)
vim.keymap.set('n', '<leader>gf', builtin.git_files, opts)
vim.keymap.set('n', '<leader>cb', builtin.current_buffer_fuzzy_find, opts)
vim.keymap.set('n', '<leader>fb', ':Telescope file_browser path=%:p:h select_buffer=true<cr>', opts)


-- Harpoon mappings
vim.keymap.set('n', '<C-f>', require('harpoon.ui').toggle_quick_menu, opts)
vim.keymap.set('n', '<C-s>', require('harpoon.mark').add_file, opts)

-- File navigation mappings
vim.keymap.set('n', '<leader>1', function() require('harpoon.ui').nav_file(1) end, opts)
vim.keymap.set('n', '<leader>2', function() require('harpoon.ui').nav_file(2) end, opts)
vim.keymap.set('n', '<leader>3', function() require('harpoon.ui').nav_file(3) end, opts)
vim.keymap.set('n', '<leader>4', function() require('harpoon.ui').nav_file(4) end, opts)
vim.keymap.set('n', '<leader>5', function() require('harpoon.ui').nav_file(5) end, opts)

-- Terminal navigation mappings
-- vim.keymap.set('n', '<A-1>', function() require('harpoon.term').gotoTerminal(1) end, opts)
-- vim.keymap.set('n', '<A-2>', function() require('harpoon.term').gotoTerminal(2) end, opts)
-- vim.keymap.set('n', '<A-3>', function() require('harpoon.term').gotoTerminal(3) end, opts)

function GetSelectText()
	local mode = vim.api.nvim_get_mode().mode
	if mode ~= 'V' and mode ~= 'v' then
		return nil
	end

	local vstart = vim.fn.getpos("'<")
	local vend = vim.fn.getpos("'>")

	local start_row = vstart[2]
	local start_col = vstart[3]
	local end_row = vend[2]
	local end_col = vend[3]

	local lines
	if mode == 'V' then
		lines = vim.fn.getline(start_row, end_row)
	elseif mode == 'v' then
		print('-------------------------')
		print('START: ', vim.inspect(vstart))
		print('END: ', vim.inspect(vend))
		lines = vim.api.nvim_buf_get_text(
			0, start_row - 1, start_col - 1, end_row - 1, end_col, {}
		)
	end

	local text = ''
	for index = 1, #lines do
		text = text .. lines[index] .. '\n'
	end

	return text
end

function SendCommandToTerminal(index, text)
	term.sendCommand(index, text)
	term.gotoTerminal(index)
end

for index = 1, num_terms do
	local term_hotkey = string.format('<A-%s>', index)
	local cmd_hotkey = string.format('<C-%s>', index)

	vim.keymap.set('n', term_hotkey, function()
		term.gotoTerminal(index)
	end, opts)

	vim.keymap.set('v', cmd_hotkey, function()
		print(1)
		local text = GetSelectText()
		SendCommandToTerminal(index, text)
	end, opts)
end
