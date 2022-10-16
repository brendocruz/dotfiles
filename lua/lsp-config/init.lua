local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
	return
end

-- UI Customization
-- Customizing how diagnostics are displayed
vim.diagnostic.config({
	-- :help vim.diagnostic.config
	virtual_text = {
		source = 'always',
	},
	float = {
		source = 'always',
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = false
})

-- Show line diagnostics automatically in hover window
vim.o.updatetime = 250
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]





--- Servers config
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- lspconfig.clangd.setup({
-- 	capabilities = capabilities
-- })

lspconfig.tsserver.setup({
	capabilities = capabilities
})

lspconfig.pyright.setup({
	capabilities = capabilities
})

lspconfig.cssls.setup({
	capabilities = capabilities
})




local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true



lspconfig.html.setup({
	capabilities = capabilities
})



lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	filetypes = {
		'html', 'typescriptreact', 'javascriptreact',
		'css', 'sass', 'scss', 'less'
	},
})



lspconfig.intelephense.setup({
	cmd = {
		'intelephense', '--stdio',
	},
	filetypes = { 'php' },
	root_dir = lspconfig.util.root_pattern('composer.json', '.git', 'wp-content') or dirname,
	-- root_dir = lspconfig.util.root_patter('*.php', 'composer.json', '.git') or vim.fn.getcwd()
	capabilities = capabilities,
	settings = {
		intelephense = {
			format = {
				enable = true,
			},
			completion = {
			},
			stubs = {
				'bcmath',
				'bz2',
				'calendar',
				'Core',
				'curl',
				'date',
				'dba',
				'dom',
				'enchant',
				'fileinfo',
				'filter',
				'ftp',
				'gd',
				'gettext',
				'hash',
				'iconv',
				'imap',
				'intl',
				'json',
				'ldap',
				'libxml',
				'mbstring',
				'mcrypt',
				'mysql',
				'mysqli',
				'password',
				'pcntl',
				'pcre',
				'PDO',
				'pdo_mysql',
				'Phar',
				'readline',
				'recode',
				'Reflection',
				'regex',
				'session',
				'SimpleXML',
				'soap',
				'sockets',
				'sodium',
				'SPL',
				'standard',
				'superglobals',
				'sysvsem',
				'sysvshm',
				'tokenizer',
				'xml',
				'xdebug',
				'xmlreader',
				'xmlwriter',
				'yaml',
				'zip',
				'zlib',
				'wordpress',
				'woocommerce',
				'wordpress-globals',
				'wp-cli',
				'elementor-stubs.php'
			}
		}
	}
})

