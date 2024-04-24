local status_ok, none_ls = pcall(require, 'null-ls')
if not status_ok then return end

local prettier_config = none_ls.builtins.formatting.prettier
-- prettier_config.filetypes = { 'json', 'jsonc' }

none_ls.setup({
	sources = {
		prettier_config
	}
})

vim.keymap.set('n', '<space>q', function()
	vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true })
