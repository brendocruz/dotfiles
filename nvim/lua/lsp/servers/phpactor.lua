local lspconfig = require('lspconfig')
local on_attach = require('lsp.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local phpactor = {
	autostart = false,
	cmd = { 'phpactor', 'language-server' },
	filetypes = { 'php' },
	root_dir = lspconfig.util.root_pattern('composer.json', '.git'),
	capabilities = capabilities,
	on_attach = on_attach,
}

return phpactor
