local on_attach = require('lsp.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

return {
	-- on_attach = on_attach,
	on_attach = function(client, buffer)
		client.server_capabilities.documentFormattingProvider = false
		on_attach(client, buffer)
	end,
	capabilities = capabilities,
	filetypes = { 'css', 'scss' },
}
