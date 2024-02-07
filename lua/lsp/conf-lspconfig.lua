-- Customizing how diagnostics are displayed
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
vim.diagnostic.config({
	-- Show source in diagnostics
	-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
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
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	group = vim.api.nvim_create_augroup("float_diagnostic_cursor", { clear = true }),
	callback = function()
		vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
	end
})



-- Go-to definition in a split window
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
local function goto_definition(split_cmd)
	local util = vim.lsp.util
	local log = require('vim.lsp.log')
	local api = vim.api

	local handler = function(_, result, ctx)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, 'No location found')
			return nil
		end

		if split_cmd then
			vim.cmd(split_cmd)
		end

		if vim.tbl_islist(result) then
			util.jump_to_location(result[1], 'utf-8')

			if #result > 1 then
				util.set_qflist(util.locations_to_items(result, ''))
				api.nvim_command('copen')
				api.nvim_command('wincmd p')
			end
		else
			util.jump_to_location(result, 'utf-8')
		end
	end

	return handler
end
vim.lsp.handlers['textDocument/definition'] = goto_definition('split')



-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = "🤬", Warn = "🖐️", Hint = "☝️", Info = "🤓" }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
