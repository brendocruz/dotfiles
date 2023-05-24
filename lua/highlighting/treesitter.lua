local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
	return
end

configs.setup({
	ensure_installed = {
		'c', 'cpp', 'lua', 'python',
		'javascript', 'typescript', 'tsx',
		'css', 'html', 'php', 'query'
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
		disable = { "php", "html", 'typescript' },
	},
	-- nvim-ts-rainbow
	-- rainbow = {
	-- 	enable = true,
	-- 	disable = { "" },
	-- 	extended_mode = true,
	-- },
	playground = {
		enable = false,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = 'o',
			toggle_hl_groups = 'i',
			toggle_injected_languages = 't',
			toggle_anonymous_nodes = 'a',
			toggle_language_display = 'I',
			focus_language = 'f',
			unfocus_language = 'F',
			update = 'R',
			goto_node = '<cr>',
			show_help = '?',
		},
	},
})

