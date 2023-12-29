local root_pattern = require('lspconfig').util.root_pattern

local on_attach = require('lsp.lsps.on_attach')
local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
	autostart = false,
	-- root_dir = root_pattern('mix.exs', '.git') or vim.loop.os_homedir(),
	on_attach = on_attach,
	capabilities = capabilities,
	-- filetypes = {
	-- 	'elixir',
	-- 	'eelixir',
	-- 	'heex',
	-- 	'surface',
	-- },
}
