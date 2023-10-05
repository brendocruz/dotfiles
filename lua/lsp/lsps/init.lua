local config_ok, lspconfig = pcall(require, 'lspconfig')
local install_ok, lspinstall = pcall(require, 'mason-lspconfig')
if not (config_ok or install_ok) then return end


local configs = require('lsp.lsps.servers')

-- Server Configuration
local function run_servers_config()
	for _, server in pairs(lspinstall.get_installed_servers()) do
		local config = configs[server]
		lspconfig[server].setup(config or {})
	end
end

run_servers_config()
