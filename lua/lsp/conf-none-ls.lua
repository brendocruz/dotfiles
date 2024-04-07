local status_ok, none_ls = pcall(require, 'null-ls')
if not status_ok then return end

none_ls.setup({
	sources = {
		none_ls.builtins.formatting.prettier
	}
})

vim.keymap.set('n', '<space>q', function()
	vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true })
