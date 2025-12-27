local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
	return
end

local lspkind = require('lspkind')
local luasnip = require("luasnip")

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

require('lazydev').setup({})

cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-b>']     = cmp.mapping.scroll_docs(-4),
		['<C-f>']     = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>']     = cmp.mapping.abort(),
		['<CR>']      = cmp.mapping.confirm({ select = false }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{
			name = 'buffer',
			option = {
				keyword_pattern = [[\k\+]],
			},
		},
		{ name = 'luasnip' },
		{ name = 'path' },
		{
			-- lazydev config.
			name = 'lazydev',
			group_index = 0,
		}
	}),
	formatting = {
		fields = { 'abbr', 'kind', 'menu' },
		expandable_indicator = false,
		format = lspkind.cmp_format({
			mode = 'symbol_text',
			maxwidth = 35,
			menu = {
				buffer = '[BUF]',
				nvim_lsp = '[LSP]',
				path = '[PTH]',
			}
		})
	},

	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end
	},

})

-- Use buffer source for `/` and `?`
cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = 'buffer' } }
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, { { name = 'cmdline', option = { ignore_cmds = { 'Man', '!' }, }, }, }
	)
})




function DisableCompletion()
	cmp.setup.buffer({ enabled = false })
end

function EnableCompletion()
	cmp.setup.buffer({ enabled = true })
end
