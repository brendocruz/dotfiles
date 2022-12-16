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

lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = {'vim'},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file('', true),
			},
			telemetry = {
				enable = false,
			}
		}
	}
})


lspconfig.tsserver.setup({
	capabilities = capabilities
})

lspconfig.pyright.setup({
	capabilities = capabilities
})





local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true



lspconfig.html.setup({
	capabilities = capabilities,
	filetypes = {
		'html'
	},
	init_options = {
		configurationSection = {'html', 'css', 'javascript'},
		embeddedLanguages = {
			css = true,
			javascript = true,
		},
		provideFormatter = true,
	},
	settings = {
		html = {
			format = {
				enable = true,
				indentInnerHtml = false,
				extraLiners = '',
				templating = true,
			}
		}
	}
})



lspconfig.emmet_ls.setup({
	capabilities = capabilities,
	filetypes = {
		'html', 'typescriptreact', 'javascriptreact',
		-- 'css', 'sass', 'scss', 'less'
	},
})



lspconfig.cssls.setup({
	capabilities = capabilities
})



lspconfig.intelephense.setup({
	cmd = {
		'intelephense', '--stdio',
	},
	filetypes = { 'php' },
	-- root_dir = lspconfig.util.root_pattern('composer.json', '.git', 'wp-content', 'plugins') or dirname,
	-- root_dir = lspconfig.util.root_pattern('wp-content', '.') or dirname,
	root_dir = lspconfig.util.root_pattern('wp-content') or vim.fn.getcwd(),
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
	}
})

