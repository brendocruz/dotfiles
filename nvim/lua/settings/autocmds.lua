function Nvim_create_augroups(definitions)
	for group_name, definition in pairs(definitions) do
		vim.api.nvim_command('augroup ' .. group_name)
		vim.api.nvim_command('autocmd!')

		for _, def in ipairs(definition) do
			local command = table.concat(vim.iter({ 'autocmd', def }):flatten():totable(), ' ')
			vim.api.nvim_command(command)
		end
		vim.api.nvim_command('augroup END')
	end
end

local autocmds = {
	terminal_job = {
		{ 'TermOpen', '*', [[tnoremap <buffer> <Esc> <c-\><c-n>]] },
		{ 'TermOpen', '*', 'startinsert' },
		{ 'TermOpen', '*', 'setlocal listchars= nonumber norelativenumber signcolumn=auto' },
	}
}

Nvim_create_augroups(autocmds)
