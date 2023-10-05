vim.cmd([[
	xmap ga <Plug>(EasyAlign)
	nmap ga <Plug>(EasyAlign)


	let g:easy_align_delimiters = {
	\	'|' : {
	\		'pattern': '\(\k\|\s\|[,.!?]\| --\)\zs||\?\ze\(-\?\k\|\s\)',
	\ 		'left_margin': 0,
	\ 		'right_margin': 0,
	\ 		'stick_to_left': 0 
	\	},
	\	'-' : {
	\		'pattern': '[^-+|]\zs--\ze\([^-+|]\|||\)',
	\ 		'left_margin': 1,
	\ 		'right_margin': 0,
	\ 		'stick_to_left': 0 
	\	},
	\	'\' : {
	\		'pattern': '\(\k\|\s\|[,.!?]\| --\)\zs||\?\ze\(-\?\k\|\s\)',
	\ 		'left_margin': 0,
	\		'delimiter_align': 'r',
	\ 		'right_margin': 0,
	\ 		'stick_to_left': 0 
	\	},
	\	'/' : {
	\		'pattern': '\(\k\|\s\|[,.!?]\| --\)\zs\(||\?\|--\)\ze\(-\?\k\|\s\)',
	\ 		'left_margin': 0,
	\ 		'right_margin': 0,
	\ 		'stick_to_left': 0 
	\	}
	\ }
]])
