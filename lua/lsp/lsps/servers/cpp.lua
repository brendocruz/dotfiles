local on_attach = require('lsp.lsps.on_attach')
local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
	on_attach = function(client, buffer)
		client.server_capabilities.documentFormattingProvider = true
		on_attach(client, buffer)
	end,
	capabilities = capabilities,
	root_dir = require('lspconfig').util.root_pattern(
		'.clangd',
		'.clang-tidy',
		'.clang-format',
		'compile_commands.json',
		'compile_flags.txt',
		'configure.ac',
		'.git'
	),
	filetypes = { 'c', 'cpp' },
	cmd = { 'clangd' },
	single_file_support = true,
}
