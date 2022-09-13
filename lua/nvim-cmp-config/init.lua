local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
	return
end

cmp.setup({
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end,
	},
	view = {
		entries = {
			name = 'custom',
			selection_order = 'near_cursor'
		}
	},
	mapping = cmp.mapping.preset.insert({
		['<C-b>']     = cmp.mapping.scroll_docs(-4),
		['<C-f>']     = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>']     = cmp.mapping.abort(),
		['<CR>']      = cmp.mapping.confirm({ select = true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'luasnip'  },
		{ name = 'buffer'   },
		{ name = 'path'     },
	}),
	formatting = {
		format = require('lspkind').cmp_format({
			mode     = 'symbol_text',
			maxwidth = 35,
			menu     = {
				buffer   = '[BUF]',
				nvim_lsp = '[LSP]',
				luasnip  = '[SNP]',
				path     = '[PTH]',
			}
		})
	}
})

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local status_ok, lspconfig = pcall(require, 'lspconfig')
if not status_ok then
	return
end

lspconfig.clangd.setup({
	capabilities = capabilities
})

lspconfig.tsserver.setup({
	capabilities = capabilities
})

lspconfig.html.setup({
	capabilities = capabilities
})

lspconfig.emmet_ls.setup({
	capabilities = capabilities
})

lspconfig.cssls.setup({
	capabilities = capabilities
})

lspconfig.pyright.setup({
	capabilities = capabilities
})
