local on_attach = require('lsp.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local emmet_ls = {
	capabilities = capabilities,
	filetypes = {
		'html', 'typescriptreact', 'javascriptreact',
		'css', 'sass', 'scss', 'less'
	},
	on_attach = on_attach,
}

return emmet_ls
