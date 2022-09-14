local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		'c', 'cpp', 'lua', 'python',
		'javascript', 'typescript', 'tsx',
		'css', 'html'
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = { ""},
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = false,
		disable = { "" },
	},
	-- nvim-ts-rainbow
	rainbow = {
		enable = true,
		disable = { "" },
		extended_mode = true,
	},
})

