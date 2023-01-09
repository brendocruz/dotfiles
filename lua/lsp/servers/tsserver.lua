local on_attach = require('lsp.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()

local tsserver_plugins = {
	{
		name = 'typescript-styled-plugin',
		location = '/usr/lib/node_modules/typescript-styled-plugin',
	},
};


return {
	init_options = {
		plugins = tsserver_plugins,
	},
	on_attach = function(client, buffer)
		client.server_capabilities.documentFormattingProvider = false
		on_attach(client, buffer)
	end,
	capabilities = capabilities,
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
}
