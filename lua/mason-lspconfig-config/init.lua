local status_ok, lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok then
	return
end

lspconfig.setup({
	ensure_installed = {
		'cssls',
		'emmet_ls',
		'html',
		'tsserver',
		'lua_ls',
		'intelephense'
	},
	automatic_installation = false,
})
