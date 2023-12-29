local lspconfig_ok,  lspconfig  = pcall(require, 'lspconfig')
local lspinstall_ok, lspinstall = pcall(require, 'mason-lspconfig')
if not (lspconfig_ok or lspinstall_ok) then return end

-- Run server configurations
for _, server in pairs(lspinstall.get_installed_servers()) do
	local config_ok, config = pcall(require, 'lsps.servers.' .. server)
	if config_ok then lspconfig[server].setup(config) end
end


local group = vim.api.nvim_create_augroup('UserLSPConfig', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
	pattern = { '*' },
	callback = function(ev)
		vim.cmd('LspStart')
	end,
	group = group
})
