local mason_ok, mason = pcall(require, 'mason')
if not mason_ok then return end

mason.setup({
	ui = {
		-- BORDERS, FLOATING WINDOWS, see `:h nvim_open_win()`
		border = 'rounded',
	},
})

