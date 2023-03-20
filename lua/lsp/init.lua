local config_ok, lspconfig = pcall(require, 'lspconfig')
local install_ok, lspinstall = pcall(require, 'mason-lspconfig')

if not (config_ok or install_ok) then
	return
end

local configs = require('lsp.servers')


-- LSP Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_status, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_status then
	capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
end


-- Server Configuration
local function run_servers_config()
	for _, server in pairs(lspinstall.get_installed_servers()) do
		local config = configs[server]
		config.capabilities = capabilities
		lspconfig[server].setup(config or {})
	end
end

run_servers_config()
