local status_ok, lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok then return end

lspconfig.setup({
	ensure_installed = {
		'clangd',
		'cssls',
		-- 'emmet_ls',
		'emmet_language_server',
		'html',
		'tsserver',
		'lua_ls',
		'intelephense',
		'dockerls',
		'docker_compose_language_service',
		'elixirls',
	},
	automatic_installation = false,
})
