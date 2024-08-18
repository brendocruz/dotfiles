local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
	return
end

local lspkind = require('lspkind')
local luasnip = require("luasnip")

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
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { 'i', 's' })
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
			require('luasnip').lsp_expand(args.body)
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
