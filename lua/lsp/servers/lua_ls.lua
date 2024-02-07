local on_attach = require('lsp.on_attach')

-- local runtime_path = vim.split(package.path, ';')
-- table.insert(runtime_path, 'lua/?.lua')
-- table.insert(runtime_path, 'lua/?/init.lua')

-- LSP Capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()

local cmp_status, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if cmp_status then
	capabilities = cmp_lsp.default_capabilities(vim.lsp.protocol.make_client_capabilities())
end

-- require("neodev").setup({
	-- add any options here, or leave empty to use the default settings
	-- override = function(root_dir, library)
	-- 	if require("neodev.util").has_file(root_dir, "/etc/nixos") then
	-- 		library.enabled = true
	-- 		library.plugins = true
	-- 	end
	-- end,
-- })

local settings = {
	Lua = {
		-- completion = {
		-- 	callSnippet = "Replace"
		-- },
		diagnostics = {
			enable = true,
			globals = { 'vim' },
		},
	}
}

-- local settings = {
-- 	Lua = {
-- 		completion = {
-- 			enable = true,
-- 		},
-- 		runtime = {
-- 			version = 'LuaJIT',
-- 			path = runtime_path,
-- 		},
-- 		diagnostics = {
-- 			enable = false,
-- 			globals = { 'vim' },
-- 		},
-- 		format = {
-- 			enable = true,
-- 		},
-- 		workspace = {
-- 			library = {
-- 				[vim.fn.expand('$VIMRUNTIME/lua')] = true,
-- 				[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
-- 			},
-- 		},
-- 		telemetry = {
-- 			enable = false,
-- 		}
-- 	}
-- }

return {
	autostart = false,
	on_attach = on_attach,
	capabilities = capabilities,
	settings = settings,
	root_dir = require('lspconfig').util.root_pattern('lua', '.'),
}
