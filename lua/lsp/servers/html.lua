local on_attach = require('lsp.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true


local init_options = {
	configurationSection = {'html', 'css', 'javascript'},
	embeddedLanguages = {
		css = true,
		javascript = true,
	},
	provideFormatter = true,
}

local settings = {
	html = {
		autoClosingTags = true,
		format = {
			enable = true,
			indentInnerHtml = true,
			extraLiners = '',
			templating = true,
		}
	}
}

return {
	on_attach = function(client, buffer)
		client.server_capabilities.documentFormattingProvider = true
		on_attach(client, buffer)
	end,
	capabilities = capabilities,
	filetypes = { 'html' },
	init_options = init_options,
	settings = settings,
}
