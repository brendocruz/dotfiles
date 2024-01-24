local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local conf = require('telescope.config').values
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

---@alias CustomPicker
---| { title: string }
---| { entries: { value: table } }
---| { entries: { display: string } }
---| { entries: { ordinal: string } }
---| { action: fun(value: table) }
---| { opts: table }

---@param picker CustomPicker
local create_picker = function(picker)
	return function(opts_tele)
		local opts = picker.opts or opts_tele or {}
		pickers.new(opts, {
			prompt_title = picker.title,
			finder = finders.new_table({
				results = picker.entries,
				entry_maker = function(entry)
					return {
						value = entry.value,
						display = entry.display,
						ordinal = entry.ordinal,
					}
				end,
			}),
			attach_mappings = function(prompt_bufnr, _)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()
					picker.entries[selection.index].action(selection.value)
				end)
				return true
			end,
			sorter = conf.generic_sorter(opts),
		}):find()
	end
end




---@type CustomPicker
local mypicker = {
	title = 'Python Commands',
	entries = {
		{
			value = { 'sleep', '5' },
			display = 'Sleep',
			ordinal = 'sleep',
			action = function(value)
				local strcmd = table.concat(value, ' ')
				vim.notify('Sleeping... [' .. strcmd .. ']')
				vim.system(value)
				vim.notify('Awake.')
			end
		},
		{
			value = { 'python3', '-m', 'venv', '.venv' },
			display = 'Create Virtual Environment',
			ordinal = 'create virutal environmet',
			action = function(value)
				local strcmd = table.concat(value, ' ')
				vim.notify('Creating virtual environment... [' .. strcmd .. ']')
				vim.system(value)
				vim.notify('Virtual environment created.')
			end
		},
		{
			value = { 'rm', '-r', '.venv' },
			display = 'Delete virtual Environment',
			ordinal = 'delete virtual environment',
			action = function(value)
				local strcmd = table.concat(value, ' ')
				vim.notify('Deleting virtual environment... [' .. strcmd .. ']')
				vim.system(value)
				vim.notify('Virtual environment deleted.')
			end
		}
	},
	opts = require('telescope.themes').get_dropdown({}) or {},
}


return require('telescope').register_extension({
	exports = {
		mycommands = create_picker(mypicker)
	},
})
