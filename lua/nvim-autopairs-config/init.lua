local status_ok, npairs = pcall(require, 'nvim-autopairs')
if not status_ok then
	return
end

-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require('cmp')
cmp.event:on(
	'confirm_done',
	cmp_autopairs.on_confirm_done()
)

npairs.setup({
	disable_filetype = { },
	enable_check_bracket_line = true,
	fast_wrap = {
		map = '<C-a>',
	},
})

