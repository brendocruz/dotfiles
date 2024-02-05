local on_attach = require('lsps.on_attach');
local lspconfig = require('lspconfig')

return {
	settings = {
		python = {
			-- pythonPath = './.venv/bin/python3',
		},
	},
	-- before_init = function(_, config)
	-- 	local pythonPath = vim.fs.find('.venv/bin/python3', {
	-- 		path = vim.fn.getcwd(),
	-- 		upward = true,
	-- 	})[1]
	-- 	if pythonPath then
	-- 		config.settings.python.pythonPath = pythonPath
	-- 	end
	-- end,
	autostart = false,
	on_attach = on_attach,
	single_file_support = true,
	-- root_dir = lspconfig.util.root_pattern('.'),
}
