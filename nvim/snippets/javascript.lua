local ls = require('luasnip')
local s, i, t = ls.s, ls.i, ls.t

-- local d = ls.dynamic_node
-- local c = ls.choice_node
local f = ls.function_node
-- local sn = ls.snippet_node

local fmt = require('luasnip.extras.fmt').fmt
-- local rep = require('luasnip.extras').rep

return {
	-- non-default import in a single line
	s('unqimp', fmt([[import {{ {} }} from '{}';]], {
		i(2, ''),
		i(1, ''),
	})),
	-- non-default import in multiple lines
	s('mulimp', fmt([[
		import {{
			{}
		}} from '{}';
	]], {
		i(2, ''),
		i(1, ''),
	})),
	-- default import
	s('defimp', fmt([[import {} from '{}';]], {
		i(2, 'name'),
		i(1, ''),
	})),
	-- require import (node js)
	s('reqimp', fmt([[const {} = require('{}');]], {
		i(2, ''),
		i(1, ''),
	})),
	-- multiple non-default export
	s('nexp', fmt(
		[[
			export {{ {} }};
		]],
		{
			i(1, 's'),
		}
	)),
	-- default export
	s('dexp', fmt(
		[[
			export default {};
		]],
		{
			i(1, ''),
		}
	)),



	-- REACT
	s('rcomponent', fmt(
		[[
			const Component = ({}) => {{
				{}

				return (
					{}
				);
			}};
		]],
		{
			i(1, 'args'),
			i(3, '// TODO: code'),
			i(2, '{{/* TODO: jsx */}}'),
		}
	)),
	-- useState hook
	s('rstate', fmt(
		[[
			const [{}, set{}] = useState({});
		]]
		,
		{
			i(1, 'state'),
			f(function(arg)
				return arg[1][1]:gsub('^%l', string.upper)
			end, { 1 }),
			i(2, '')
		}
	)),
	s('reffect', fmt(
		[[
			useEffect(() => {{
				{}
			}}, [{}]);
		]],
		{
			i(2, '// TODO: something'),
			i(1, 'dependencies'),
		}
	)),

}, {}
