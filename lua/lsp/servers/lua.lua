local on_attach = require('lsp.on_attach')

-- local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- local capabilities = vim.lsp.protocol.make_client_capabilities()

local settings = {
	Lua = {
		completion = {
			enable = true,
		},
		runtime = {
			version = 'LuaJIT',
		},
		diagnostics = {
			enable = true,
			globals = { 'vim' },
		},
		format = {
			enable = true,
		},
		workspace = {
			library = vim.api.nvim_get_runtime_file('', true),
		},
		telemetry = {
			enable = false,
		}
	}
}

return {
	on_attach = on_attach,
	-- capabilities = capabilities,
	settings = settings,
}
