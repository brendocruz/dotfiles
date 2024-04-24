local config_ok, lspconfig = pcall(require, 'mason-lspconfig')
if not config_ok then return end

lspconfig.setup({
	ensure_installed = {
		-- Web Development
		'html',
		'cssls',
		'tsserver',
		'emmet_language_server',
		'intelephense',

		-- Docker
		'dockerls',
		'docker_compose_language_service',

		-- Python
		'pyright', -- autocompletation
		'ruff_lsp', -- linter and code formatter

		-- Others
		'clangd',
		'lua_ls',
		'elixirls',
	},
	automatic_installation = false,
})
