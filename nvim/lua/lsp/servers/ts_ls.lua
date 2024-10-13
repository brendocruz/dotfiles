local on_attach = require('lsp.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()

local tsserver_plugins = {
	{
		name = '@styled/typescript-styled-plugin',
		location = '/usr/lib/node_modules/@styled/typescript-styled-plugin',
	},
};


return {
	autostart = false,
	root_dir = require('lspconfig').util.root_pattern('tsconfig.json', 'jsconfig.json', 'package.json'),
	init_options = {
		plugins = tsserver_plugins,
	},
	on_attach = function(client, buffer)
		-- client.server_capabilities.documentFormattingProvider = false
		on_attach(client, buffer)
	end,
	capabilities = capabilities,
	filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
	cmd = { 'typescript-language-server', '--stdio' },
}
