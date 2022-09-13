local status_ok, mason = pcall(require, 'mason')
if not status_ok then
	return
end

mason.setup({
	ui = {
		border = 'none' -- :h nvim_open_win(), border
	},

})

