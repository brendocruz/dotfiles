local on_attach = function(client, bufnr)
	-- -- Enable completion triggered by <c-x><c-o>
	-- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	local formatFunction = function() vim.lsp.buf.format({ async = true }) end

	-- Mappings
	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	vim.keymap.set('n', '<space>q', formatFunction, bufopts)
	vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', '[d', vim.diagnostic.goto_next, bufopts)
	vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, bufopts)
	-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)

	-- Telescope
	vim.keymap.set('n', '<space>d', '<CMD>Telescope diagnostics<CR>', bufopts)




	-- Show line diagnostics automatically in hover window
	-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				-- border = 'rounded',
				source = 'always',
				prefix = ' ',
				scope = 'cursor',
			}
			vim.diagnostic.open_float(nil, opts)
		end
	})



	-- Highlight symbol under cursor
	-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization
	if client.server_capabilities.documentHighlightProvider then
		-- Transparency: https://github.com/neovim/neovim/issues/7064
		vim.cmd [[
			hi! LspReferenceRead cterm=bold ctermbg=red blend=LightYellow
			hi! LspReferenceText cterm=bold ctermbg=red blend=LightYellow
			hi! LspReferenceWrite cterm=bold ctermbg=red blend=LightYellow
		]]
		vim.api.nvim_create_augroup('lsp_document_highlight', {
			clear = false
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = 'lsp_document_highlight',
		})
		vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
			group = 'lsp_document_highlight',
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
			group = 'lsp_document_highlight',
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

return on_attach
