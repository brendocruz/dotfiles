local status_ok, ls = pcall(require, 'luasnip')
if not status_ok then
	return
end

ls.setup({
	history = true,
	updateevents = 'TextChanged,TextChangedI',
	-- enable_autosnippets = true,
	-- snip_env = {
	-- s = function(...)
	-- 	local snip = ls.s(...)
	-- 	table.insert(getfenv(2).ls_file_snippets, snip)
	-- end,
	-- parse = function(...)
	-- 	local snip = ls.parser.parse_snippet(...)
	-- 	table.insert(getfenv(2).ls_file_snippets, snip)
	-- end
	-- }
})

require('luasnip.loaders.from_lua').load({
	paths = '~/.config/nvim/snippets/'
})


-- Keymaps
-- local opts = { noremap = true, silent = true }
-- vim.keymap.set({"i"}, "<C-K>", function() luasnip.expand() end, opts)
-- vim.keymap.set({"i", "s"}, "<C-L>", function() luasnip.jump( 1) end, opts)
-- vim.keymap.set({"i", "s"}, "<C-J>", function() luasnip.jump(-1) end, opts)

-- vim.keymap.set({"i", "s"}, "<C-E>", function()
-- 	if luasnip.choice_active() then
-- 		luasnip.change_choice(1)
-- 	end
-- end, {silent = true}

-- local s = ls.s
-- ls.snippets = {
-- 	lua = {
-- 		s('req', ),
-- 	}
-- }


-- shortcut to source my luasnips file again, which will reload my snippets
vim.keymap.set('n', '<leader><leader>s', '<cmd>source ~/.config/nvim/lua/autocompletation/luasnip.lua<CR>')


-- MAPPING
local opts = { silent = true }
vim.keymap.set({ 'i' }, '<C-K>', function() ls.expand() end, opts)
vim.keymap.set({ 'i', 's' }, '<C-L>', function() ls.jump(1) end, opts)
vim.keymap.set({ 'i', 's' }, '<C-J>', function() ls.jump(-1) end, opts)
vim.keymap.set({ 'i', 's' }, '<C-E>', function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end, opts)
