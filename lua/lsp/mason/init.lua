local status_ok, mason = pcall(require, 'mason')
if not status_ok then
	return
end

-- BORDERS, FLOATING WINDOWS...
-- :h nvim_open_win()

mason.setup({
	ui = {
		border = 'rounded',
	},
})
