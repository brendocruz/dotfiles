local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
	return
end


-- UI Customization
-- https://github.com/neovim/nvim-lspconfig/wiki/UI-Customization

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
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
-- For diagnostics for specific cursor position
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
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
-- You will likely want to reduce updatetime which affects CursorHold
-- note: this setting is global and should be set only once
vim.o.updatetime = 250
-- For diagnostics for specific cursor position
vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]


-- Highlight line number instead of having icons in sign column
vim.cmd [[
	highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
	highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
	highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
	highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

	sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
	sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
	sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
	sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
]]

-- Change prefix/character preceding the diagnostics' virtual text
vim.diagnostic.config({
	virtual_text = {
		prefix = '■', -- Could be '●', '▎', 'x'
	}
})

-- Change diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Print diagnostics to message area
function PrintDiagnostics(opts, bufnr, line_nr, client_id)
	bufnr = bufnr or 0
	line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
	opts = opts or {['lnum'] = line_nr}

	local line_diagnostics = vim.diagnostic.get(bufnr, opts)
	if vim.tbl_isempty(line_diagnostics) then return end

	local diagnostic_message = ""
	for i, diagnostic in ipairs(line_diagnostics) do
		diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
		print(diagnostic_message)
		if i ~= #line_diagnostics then
			diagnostic_message = diagnostic_message .. "\n"
		end
	end
	vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
end

vim.cmd [[ autocmd! CursorHold * lua PrintDiagnostics() ]]

-- Go-to definition in a split window
local function goto_definition(split_cmd)
	local util = vim.lsp.util
	local log = require("vim.lsp.log")
	local api = vim.api

	-- note, this handler style is for neovim 0.5.1/0.6, if on 0.5, call with function(_, method, result)
	local handler = function(_, result, ctx)
		if result == nil or vim.tbl_isempty(result) then
			local _ = log.info() and log.info(ctx.method, "No location found")
			return nil
		end

		if split_cmd then
			vim.cmd(split_cmd)
		end

		if vim.tbl_islist(result) then
			util.jump_to_location(result[1])

			if #result > 1 then
				util.set_qflist(util.locations_to_items(result))
				api.nvim_command("copen")
				api.nvim_command("wincmd p")
			end
		else
			util.jump_to_location(result)
		end
	end

	return handler
end

vim.lsp.handlers["textDocument/definition"] = goto_definition('split')






-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }

-- vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
-- vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	-- Enable completion triggered by <c-x><c-o>
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	-- See `:help vim.lsp.*` for documentation on any of the below functions
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
	-- vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
	-- vim.keymap.set('n', '<space>wl', function()
	--   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
	-- end, bufopts)
	-- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
	vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
	vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

	-- From UI Customization
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				-- border = 'rounded',
				source = 'always',
				prefix = ' ',
				scope = 'cursor',
			}
			vim.diagnostic.open_float(nil, opts)
		end
	})

	-- Highlight symbol under cursor
	-- if client.resolved_capabilities.document_highlight then
	if client.server_capabilities.documentHighlightProvider then
		-- Transparency: https://github.com/neovim/neovim/issues/7064
		vim.cmd [[
			hi! LspReferenceRead cterm=bold ctermbg=red blend=LightYellow
			hi! LspReferenceText cterm=bold ctermbg=red blend=LightYellow
			hi! LspReferenceWrite cterm=bold ctermbg=red blend=LightYellow
		]]
		vim.api.nvim_create_augroup('lsp_document_highlight', {
			clear = false
		})
		vim.api.nvim_clear_autocmds({
			buffer = bufnr,
			group = 'lsp_document_highlight',
		})
		vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
			group = 'lsp_document_highlight',
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
			group = 'lsp_document_highlight',
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local lsp_flags = {
	-- This is the default in Nvim 0.7+
	debounce_text_changes = 150,
}











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
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
})

lspconfig.pyright.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	flags = lsp_flags,
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
	},
	on_attach = on_attach,
	flags = lsp_flags,
})

