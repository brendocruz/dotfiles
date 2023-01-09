local lspconfig = require('lspconfig')
local on_attach = require('lsp.on_attach')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local intelephense = {
	-- cmd = {
	-- },
	filetypes = { 'php' },
	-- root_dir = lspconfig.util.root_pattern('composer.json', '.git', 'wp-content', 'plugins') or dirname,
	-- root_dir = lspconfig.util.root_pattern('wp-content', '.') or dirname,
	-- root_dir = lspconfig.util.root_pattern('wp-content') or vim.fn.getcwd(),
	-- root_dir = lspconfig.util.root_patter('*.php', 'composer.json', '.git') or vim.fn.getcwd()
	capabilities = capabilities,
	settings = {
		intelephense = {
			diagnostics = {
				enable = true,
				embeddedLanguages = {
					'html'
				},
			},
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
	},
	on_attach = on_attach,
}

return intelephense
