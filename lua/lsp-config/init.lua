local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
	return
end

local capabilites = require('cpm_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilites())

lspconfig.tsserver.setup({ })
lspconfig.clangd.setup({
	capabilites = capabilites
})
