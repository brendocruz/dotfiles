local status_ok, mason = pcall(require, 'mason')
if not status_ok then return end


mason.setup({
	ui = {
		-- BORDERS, FLOATING WINDOWS, see `:h nvim_open_win()`
		border = 'rounded',
	},
})
