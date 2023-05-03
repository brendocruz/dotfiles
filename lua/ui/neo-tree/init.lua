local statusok, neotree = pcall(require, 'neo-tree')
if not statusok then
	return
end

neotree.setup({
	event_handlers = {
		{
			event = "file_opened",
			handler = function(file_path)
				require("neo-tree").close_all()
			end
		},
	},
	popup_border_style = 'rounded',
	window = {
		position = 'float',
		width = 40,
		mapping_options = {
			noremap = true,
			nowait = true,
		},
		mappings = {
			['l'] = 'open',
			['h'] = 'close_node',
		}
	},
	filesystem = {
		components = {
			name = function(config, node, state)
				local highlight = config.highlight

				local name = node.name
				if node.type == 'directory' then
					if string.sub(name, 1, 1) == '~' then
						local range_start, range_end = string.find(name, '/[^/]*$')
						if range_start ~= nil then
							local path = string.sub(name, range_start, range_end)
							name = '.' .. path
						end
					end
				end

				return {
					text = name,
					highlight = highlight,
				}
			end
		},
		filtered_items = {
			hide_by_name = {
				'node_modules',
				'package.json',
				'package-lock.json',
				'tsconfig.json',
				'README.md',
			},
			hide_by_pattern = {
				'webpack*.js',
			},
			always_show = {
				".gitignored"
			},
			never_show = {
				'.git',
			},
			never_show_by_pattern = {
			},
		},
	},
})


-- Mappings
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>e', ':Neotree toggle reveal position=float<CR>', opts)
