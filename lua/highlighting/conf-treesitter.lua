local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
	return
end

configs.setup({
	modules = {},
	ignore_install = {},
	ensure_installed = {
		'c',
		'cpp',
		'lua',
		'python',
		'javascript',
		'tsx',
		'json',
		'jsdoc',
		'typescript',
		'css',
		'html',
		'php',
		'query',
		'elixir',
		'ocaml',
	},
	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = true,
	},
	indent = {
		enable = true,
		disable = {
			'html',
			'python',
			'php',
			'lua',
			'javascript',
			'tsx',
			'json',
			'jsdoc',
			'typescript',
		},
	},
	playground = {
		enable = false,
		disable = {},
		updatetime = 25,   -- Debounced time for highlighting nodes in the playground from source code
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


--local tbl = {}
--
--function tbl.contains(_tbl, value)
--	for _, current in pairs(_tbl) do
--		if current == value then
--			return true
--		end
--	end
--
--	return false
--end
--
--local function directives__()
--	local function is_one_line(range)
--		return range[1] == range[3]
--	end
--
--	local function is_range_empty_or_invalid(range)
--		if range[3] < range[1] or (is_one_line(range) and range[4] <= range[2]) then
--			return true
--		end
--
--		return false
--	end
--
--	local function make_subranges_between_children_like(node, predicate)
--		local content = { { node:range() } }
--
--		for child in node:iter_children() do
--			if predicate(child) then
--				local child_range = { child:range() }
--				local last_content_range = content[#content]
--				local first_part = {
--					last_content_range[1],
--					last_content_range[2],
--					child_range[1],
--					child_range[2],
--				}
--				local second_part = {
--					child_range[3],
--					child_range[4],
--					last_content_range[3],
--					last_content_range[4],
--				}
--				if is_range_empty_or_invalid(first_part) then
--					if not is_range_empty_or_invalid(second_part) then
--						content[#content] = second_part
--					end
--				elseif is_range_empty_or_invalid(second_part) then
--					content[#content] = first_part
--				else
--					content[#content] = first_part
--					content[#content + 1] = second_part
--				end
--			end
--		end
--
--		return content
--	end
--
--	local directives = vim.treesitter.query.list_directives()
--	if not tbl.contains(directives, "inject_without_named_children!") then
--		vim.treesitter.query.add_directive(
--			"inject_without_named_children!",
--			function(
--				match,
--				_, --[[ pattern ]]
--				_, --[[ bufnr ]]
--				predicate,
--				metadata
--			)
--				local node = match[predicate[2]]
--				metadata.content = make_subranges_between_children_like(
--					node,
--					function(child)
--						return child:named()
--					end
--				)
--			end
--		)
--	end
--
--	if not tbl.contains(directives, "inject_without_children!") then
--		vim.treesitter.query.add_directive("inject_without_children!", function(
--			match,
--			_, --[[ pattern ]]
--			_, --[[ bufnr ]]
--			predicate,
--			metadata
--		)
--			local node = match[predicate[2]]
--			metadata.content = make_subranges_between_children_like(node, function(_)
--				return true
--			end)
--		end)
--	end
--end
--
--local ecma_injections = [[
--(comment) @jsdoc
--(comment) @comment
--(regex_pattern) @regex
--
--; =============================================================================
--; languages
--
--; {lang}`<{lang}>`
--(call_expression
--function: ((identifier) @language)
--arguments: ((template_string) @content
--  (#offset! @content 0 1 0 -1)
--  (#inject_without_children! @content)))
--
--; gql`<graphql>`
--(call_expression
--function: ((identifier) @_name
--  (#eq? @_name "gql"))
--arguments: ((template_string) @graphql
--  (#offset! @graphql 0 1 0 -1)
--  (#inject_without_children! @graphql)))
--
--; hbs`<glimmer>`
--(call_expression
--function: ((identifier) @_name
--  (#eq? @_name "hbs"))
--arguments: ((template_string) @glimmer
--  (#offset! @glimmer 0 1 0 -1)
--  (#inject_without_children! @glimmer)))
--
--; =============================================================================
--; styled-components
--
--; styled.div`<css>`
--(call_expression
--function: (member_expression
--  object: (identifier) @_name
--    (#eq? @_name "styled"))
--arguments: ((template_string) @css
--  (#offset! @css 0 1 0 -1)
--  (#inject_without_children! @css)))
--
--; styled(Component)`<css>`
--(call_expression
--function: (call_expression
--  function: (identifier) @_name
--    (#eq? @_name "styled"))
--arguments: ((template_string) @css
--  (#offset! @css 0 1 0 -1)
--  (#inject_without_children! @css)))
--
--; styled.div.attrs({ prop: "foo" })`<css>`
--(call_expression
--function: (call_expression
--  function: (member_expression
--    object: (member_expression
--      object: (identifier) @_name
--        (#eq? @_name "styled"))))
--arguments: ((template_string) @css
--  (#offset! @css 0 1 0 -1)
--  (#inject_without_children! @css)))
--
--; styled(Component).attrs({ prop: "foo" })`<css>`
--(call_expression
--function: (call_expression
--  function: (member_expression
--    object: (call_expression
--      function: (identifier) @_name
--        (#eq? @_name "styled"))))
--arguments: ((template_string) @css
--  (#offset! @css 0 1 0 -1)
--  (#inject_without_children! @css)))
--
--; createGlobalStyle`<css>`
--(call_expression
--function: (identifier) @_name
--  (#eq? @_name "createGlobalStyle")
--arguments: ((template_string) @css
--  (#offset! @css 0 1 0 -1)
--  (#inject_without_children! @css)))
--
--; keyframes`<css>`
--(call_expression
--function: (identifier) @_name
--  (#eq? @_name "keyframes")
--arguments: ((template_string) @css
--  (#offset! @css 0 1 0 -1)
--  (#inject_without_children! @css)))
--]]
--
--directives__()
--vim.treesitter.query.set("javascript", "injections", ecma_injections)
--vim.treesitter.query.set("typescript", "injections", ecma_injections)
--vim.treesitter.query.set("tsx", "injections", ecma_injections)
