local status_ok, lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok then return end

lspconfig.setup({
	ensure_installed = {
		-- HTML, CSS, JavaScript
		'html',
		'cssls',
		'tsserver',
		'emmet_language_server',

		-- Docker
		'dockerls',
		'docker_compose_language_service',

		-- Python
		'pyright',  -- autocompletation
		'ruff_lsp', -- linter and code formatter

		-- Others
		'clangd',
		'lua_ls',
		'intelephense',
		'elixirls',
	},
	automatic_installation = false,
})
