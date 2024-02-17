local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
	return
end

local lspkind = require('lspkind')

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }

cmp.setup({
	view = {
		entries = {
			name = 'custom',
			selection_order = 'near_cursor'
		}
	},
	mapping = cmp.mapping.preset.insert({
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
		['<Tab>'] = function(fallback)
			if not cmp.select_next_item() then
				fallback()
			end
		end,
		['<S-Tab>'] = function(fallback)
			if not cmp.select_prev_item() then
				fallback()
			end
		end,
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{
			name = 'buffer',
			option = {
				keyword_pattern = [[\k\+]],
			},
		},
		{ name = 'path' },
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
