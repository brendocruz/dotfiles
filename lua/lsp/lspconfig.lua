-- UI Customization
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization

-- Customizing how diagnostics are displayed
-- :help vim.diagnostic.config for more advanced customization options.
vim.diagnostic.config({
	-- Show source in diagnostics
	virtual_text = {
		source = 'always',
	},
	float = {
		source = 'always',
	},

	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = false,
})





-- Show line diagnostics automatically in hover window
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
-- For diagnostics for specific cursor position
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]





-- Go-to definition in a split window
local function goto_definition(split_cmd)
	local util = vim.lsp.util
	local log = require('vim.lsp.log')
	local api = vim.api

	-- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
	local handler = function(_, result, ctx)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, 'No location found')
			return nil
		end

		if split_cmd then
			vim.cmd(split_cmd)
		end

		if vim.tbl_islist(result) then
			util.jump_to_location(result[1])

			if #result > 1 then
				util.set_qflist(util.locations_to_items(result))
				api.nvim_command('copen')
				api.nvim_command('wincmd p')
			end
		else
			util.jump_to_location(result)
		end
	end

	return handler
end

vim.lsp.handlers['textDocument/definition'] = goto_definition('split')





-- Change prefix/character preceding the diagnostics' virtual text
vim.diagnostic.config({
	virtual_text = {
		prefix = '■', -- Could be '●', '▎', 'x'
	}
})




-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
	local hl = 'DiagnosticSign' .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
