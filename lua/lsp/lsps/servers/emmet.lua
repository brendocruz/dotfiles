local on_attach = require('lsp.lsps.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local emmet_ls = {
	-- capabilities = capabilities,
	filetypes = {
		'html',
		'typescriptreact',
		'javascriptreact',
		'css',
		'sass',
		'scss',
		'less',
		'xml'
	},
	-- on_attach = on_attach,
	-- html = {
	-- 	options = {
	-- 		['bem.enabled'] = true,
	-- 	}
	-- },
	-- javascriptreact = {
	-- 	options = {
	-- 		['jsx.enabled'] = true,
	-- 	}
	-- }
}

return emmet_ls
