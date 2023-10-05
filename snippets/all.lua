-- -- local ls = require('luasnip')
-- -- local s = ls.s --> snippet
-- -- local i = ls.i --> insert node
-- -- local t = ls.t --> text node
-- -- local d = ls.dynamic_node
-- -- local c = ls.choice_node
-- -- local f = ls.function_node
-- -- local sn = ls.snippet_node
-- -- local fmt = require('luasnip.extras.fmt').fmt
-- -- local rep = require('luasnip.extras').rep

-- local example = s('example', {
-- 	t('-- this is an example snippet')
-- })

-- -- local snippets, autosnippets = {}, {}
-- local snippets = {
-- 	example,
-- }
-- -- local group = vim.api.nvim_create_augroup('Lua Snippets', { clear = true })
-- -- local file_pattern = '*.lua'



-- -- local myFirstSnippet = s('myFirstSnippet', {
-- -- 	t('Hi! This is my first snippet'),
-- -- 	i(1, 'placeholder_text'),
-- -- 	t({ 'First line', '', 'Third line' })
-- -- })
-- -- table.insert(snippets, myFirstSnippet)

-- -- local mySecondSnippet = s('mySecondSnippet', fmt([[
-- -- 	local {} = function({})
-- -- 	{}
-- -- 	{{ }} -- open curly braces: {{
-- -- 	end
-- -- ]], {
-- -- 	i(1, 'myVar'),
-- -- 	i(2, 'myArg'),
-- -- 	i(3, '-- TODO: SOMETHING'),
-- -- 	c(4, { t('option1'), t('option2'), i('something') })
-- -- }))

-- -- -- local myFirstAutoSnippet = s('auto-', {
-- -- -- 	t('This was auto triggered')
-- -- -- })
-- -- local myFirstAutoSnippet = s({
-- -- 	trig = 'digit%d',
-- -- 	regTrig = true, -- triggers regex
-- -- 	hidden = true -- don't show in the autocommplet
-- -- 	-- auto snippets are hidden by default
-- -- }, {
-- -- 	t('This was auto triggered'),
-- -- 	i(1, 'lets try this'),
-- -- 	f(function(arg, snip)
-- -- 		local cp = snip.captures[1]
-- -- 		local try = arg[1][1]:upper(1)
-- -- 		return 'my string'
-- -- 	end, 1),
-- -- 	-- end, {1, 2})
-- -- 	rep(1) -- repeat
-- -- })



-- -- local dynamic_node_first = s(
-- -- 	{
-- -- 		trig = 'digit%d',
-- -- 		regTrig = true, -- triggers regex
-- -- 		hidden = true -- don't show in the autocommplet
-- -- 	}, {
-- -- 		d(1, function(_, snip)
-- -- 			return sn(i, {
-- -- 				i(1, snip.captures[1])
-- -- 			})
-- -- 		end)
-- -- 	}
-- -- )

-- -- return snippets, autosnippets
-- return snippets, {}
