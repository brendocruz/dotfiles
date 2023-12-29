local on_attach = require('lsp.lsps.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


local init_options = {
	configurationSection = { 'html', 'css', 'javascript' },
	embeddedLanguages = {
		css = true,
		javascript = true,
	},
	provideFormatter = true,
}

local settings = {
	html = {
		autoClosingTags = false,
		format = {
			enable = true,
			indentInnerHtml = false,
			extraLiners = '',
			templating = true,
			wrapLineLength = vim.api.nvim_get_option('textwidth'),
			wrapAttributes = 'force-expand-multiline',
		},
	},
}

return {
	autostart = false,
	on_attach = function(client, buffer)
		client.server_capabilities.documentFormattingProvider = true
		on_attach(client, buffer)
	end,
	capabilities = capabilities,
	filetypes = { 'html' },
	init_options = init_options,
	settings = settings,
}
