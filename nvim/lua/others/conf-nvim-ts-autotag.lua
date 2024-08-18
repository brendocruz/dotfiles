local status_ok, autotag = pcall(require, 'nvim-ts-autotag')
if not status_ok then
	return
end

autotag.setup({
	opts = {
		-- filetypes = {
		-- 	'html', 'xml', 'php', 'markdown', 'javascriptreact', 'typescriptreact',
		-- 	'javascript', 'typescript'
		-- },
		-- enable_close_on_slash = true,
	}
})


-- Enable update on insert
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{
		underline = true,
		virtual_text = {
			spacing = 5,
			severity_limit = 'Warning',
		},
		update_in_insert = true,
	}
)
