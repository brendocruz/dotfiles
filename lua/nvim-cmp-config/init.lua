local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
	return
end

local luasnip = require('luasnip')

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
		-- ['<C-p>']     = cmp.mapping.scroll_docs(-4),
		-- ['<C-n>']     = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>']     = cmp.mapping.abort(),
		['<CR>']      = cmp.mapping.confirm({ select = true }),
		['<Tab>']     = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expend_or_jump()
			else
				fallback()
			end
		end, {'i', 's'}),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {'i', 's'})
		-- source: https://github.com/Abstract-IDE/Abstract/blob/main/lua/plugins/nvim-cmp.lua
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

