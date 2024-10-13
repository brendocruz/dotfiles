local status_ok, telescope = pcall(require, 'telescope')
if not status_ok then
	return
end


telescope.setup({
	defaults = {
		prompt_prefix = '$ ',
		file_ignore_patterns = {
			'node_modules', 'dist', 'node_modules/**/*',
			'__pycache__', 'vendor'
		},
	},
	extensions = {
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = 'smart_case',
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



-- Load Telescope Extensions
telescope.load_extension('fzf')
telescope.load_extension('harpoon')



-- Telescope mappings
local builtin = require('telescope.builtin')
local opts = { noremap = true, silent = true }


-- Search for file in my cookbook folder (Find Help).
vim.keymap.set('n', '<leader>fh', function()
	builtin.live_grep({
		search_dirs = { '~/Documentos/Projetos/Repos/Cookbook' },
		cwd = '~/Documentos/Projetos/Repos/Cookbook',
	})
end, opts)

vim.keymap.set('n', '<leader>fm', ':Telescope mycommands<CR>', opts)


-- Search for files in the current working directory (Find Files)
vim.keymap.set('n', '<leader>ff', builtin.find_files, opts)
-- List open buffers (Buffer)
vim.keymap.set('n', '<leader>b', builtin.buffers, opts)
-- Search for git files (Git Files)
vim.keymap.set('n', '<leader>gf', builtin.git_files, opts)
-- Search for a string in the current buffer (Current Buffer Find)
vim.keymap.set('n', '<leader>cbf', builtin.current_buffer_fuzzy_find, opts)
-- Search for a string in the current project (Current Project Find)
vim.keymap.set('n', '<leader>cpf', builtin.live_grep, opts)
-- Open file browser (File Browser)
vim.keymap.set('n', '<leader>fb', ':Explore<cr>', opts)
-- Search for help tags
vim.keymap.set('n', '<leader>ht', builtin.help_tags, opts)

-- list lsp symbols in the current workspace
vim.keymap.set('n', '<leader>lws', builtin.lsp_workspace_symbols, opts)
-- list lsp symbols in the current document
vim.keymap.set('n', '<leader>ls', builtin.lsp_document_symbols, opts)
-- List Diagnostics for all open buffers
-- vim.keymap.set('n', '', builtin.diagnostics, opts)


-- Search for the word under the cursor in the current
-- working directory (Project Word Search)
vim.keymap.set('n', '<leader>pws', function()
	local word = vim.fn.expand('<cword>')
	builtin.grep_string({ search = word })
end)

-- Search for the WORD under the cursor in the current
-- working directory (Project WORD Search)
vim.keymap.set('n', '<leader>pWs', function()
	local word = vim.fn.expand('<cWORD>')
	builtin.grep_string({ search = word })
end)


-- Harpoon mappings
vim.keymap.set('n', '<C-f>', require('harpoon.ui').toggle_quick_menu, opts)
vim.keymap.set('n', '<C-s>', require('harpoon.mark').add_file, opts)

-- File navigation mappings
vim.keymap.set('n', '<leader>1', function() require('harpoon.ui').nav_file(1) end, opts)
vim.keymap.set('n', '<leader>2', function() require('harpoon.ui').nav_file(2) end, opts)
vim.keymap.set('n', '<leader>3', function() require('harpoon.ui').nav_file(3) end, opts)
vim.keymap.set('n', '<leader>4', function() require('harpoon.ui').nav_file(4) end, opts)
vim.keymap.set('n', '<leader>5', function() require('harpoon.ui').nav_file(5) end, opts)



-- Harpoon mapping
local term = require('harpoon.term')
local num_terms = 4


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
	-- local term_hotkey = string.format('<A-%s>', index)
	local cmd_hotkey = string.format('<C-%s>', index)

	-- Terminal mappings
	-- vim.keymap.set('n', term_hotkey, function()
	-- 	term.gotoTerminal(index)
	-- end, opts)

	-- Send command to terminal mappings
	vim.keymap.set('v', cmd_hotkey, function()
		local text = GetSelectText()
		SendCommandToTerminal(index, text)
	end, opts)
end
