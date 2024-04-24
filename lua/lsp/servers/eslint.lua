local on_attach = require('lsp.on_attach')
local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
	autostart = false,
	-- root_dir = require('lspconfig').util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json'),
	on_attach = on_attach,
	-- on_attach = function(client, buffer)
	-- 	client.server_capabilities.documentFormattingProvider = true
	-- 	on_attach(client, buffer)
	-- end,
	capabilities = capabilities,
	single_file_support = true,
}
