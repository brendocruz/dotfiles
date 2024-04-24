local on_attach = require('lsp.on_attach')
local capabilities = vim.lsp.protocol.make_client_capabilities()


return {
	autostart = false,
	on_attach = function(client, buffer)
		client.server_capabilities.documentFormattingProvider = true
		-- client.server_capabilities.hoverProvider = false
		on_attach(client, buffer)
	end,
	capabilities = capabilities,
	init_options = {
		settings = {
		},
		args = {},
	},
	settings = {},
	filetypes = {
		'python',
	},
}
