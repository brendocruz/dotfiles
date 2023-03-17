let s:selfclosingpattern = '<\/*\zs\%(area\|base\|br\|col\|embed\|hr\|img\|input\|link\|meta\|param\|source\|track\|wbr\)\ze\%(\%(\s\|\n\|\r\)\|>\)'
let s:opentagpattern = '<\w\+\%(\s\|\n\|\r\)*[^<>]*\%(\s\|\n\|\r\)*>'
let s:closetagpattern = '<\/\w\+\%(\s\|\n\|\r\)*>'
let s:attrpattern = '\%(\s\|\n\|\r\)\zs\(\w\+\%(\s\|\n\|\r\)*=\%(\s\|\n\|\r\)*\"[^\"]*\"\|\w\+\%(\s\|\n\|\r\)*=\%(\s\|\n\|\r\)*''[^'']*''\|\w\+\%(\s\|\n\|\r\)*=\%(\s\|\n\|\r\)*\%(\w\|-\)\+\|\w\+\)\ze\%(\%(\s\|\n\|\r\)\|\/\|>\)'
let s:tagnamepattern = '<\/*\zs\w\+\ze\%(\s\|\n\|\r\)*'

function! IsInRange(cursorpos, startpos, endpos)
	if a:startpos[0] < a:cursorpos[0] && a:endpos[0] > a:cursorpos[0]
		return 1
	elseif a:startpos[0] == a:cursorpos[0] && a:startpos[1] <= a:cursorpos[1]
		return 1
	elseif a:endpos[0] == a:cursorpos[0] && a:endpos[1] >= a:cursorpos[1]
		return 1
	endif
	return 0
endfunction

function! SearchPreviousOpenTag()
	let l:pattern = s:opentagpattern

	let l:tagend   = searchpos(l:pattern, 'bWe')
	let l:tagstart = searchpos(l:pattern, 'bW')
	return [l:tagstart, l:tagend]
endfunction

function! SearchNextOpenTag()
	let l:pattern = s:opentagpattern

	let l:tagend   = searchpos(l:pattern, 'We')
	let l:tagstart = searchpos(l:pattern, 'W')
	return [l:tagstart, l:tagend]
endfunction

function! SearchNextCloseTag()
	let l:pattern = s:closetagpattern

	let l:tagstart = searchpos(l:pattern, 'W')
	let l:tagend   = searchpos(l:pattern, 'We')
	return [l:tagstart, l:tagend]
endfunction

function! SearchEnclosingTag()
	let l:cursorstart = [line('.'), col('.')]

	let l:startpattern = s:opentagpattern
	let l:endpattern = s:closetagpattern
	let l:skip = 'getline(".") =~ "' . escape(s:selfclosingpattern, '\') . '"'


	let l:pairend = searchpairpos(l:startpattern, '', l:endpattern, 'W', l:skip)
	let l:tagstartname = GetTagName()[0]
	let l:pairstart = searchpairpos(l:startpattern, '', l:endpattern . '\zs', 'bW', l:skip)
	return [l:pairstart, l:pairend, l:tagstartname]
endfunction

function! GetTagName()
	let l:pattern = s:tagnamepattern
	let l:tagnamestart = searchpos(l:pattern, 'W')
	let l:tagnameend = searchpos(l:pattern, 'We')
	let l:tagname = getline('.')[l:tagnamestart[1] - 1:l:tagnameend[1] - 1]
	return [l:tagname, l:tagnamestart, l:tagnameend]
endfunction

function GetTagData(starttagstart, starttagend)
	" Move cursor to the beginning of the start tag
	call cursor(a:starttagstart)


	" Get tag name
	let l:tagname = GetTagName()[0]


	" Get tag attributes data
	let l:pattern = s:attrpattern
	let l:attrs = []

	let l:foundlast = 0
	while l:foundlast != 1
		" Get attribute start and end
		let l:attrstart = searchpos(l:pattern, 'W')
		if l:attrstart == [0,0]
			let l:foundlast = 1
		endif
		let l:attrend = searchpos(l:pattern, 'We')
		" echo [l:attrstart, a:starttagstart, a:starttagend]

		if IsInRange(l:attrstart, a:starttagstart, a:starttagend) == 0
			let l:foundlast = 1
		else
			call add(l:attrs, { 'start': l:attrstart, 'end': l:attrend })
		endif
	endwhile


	" Move cursor to the beginning
	call cursor(a:starttagstart)


	let l:tagdata = { 'tag': l:tagname, 'attrs': l:attrs }
	return l:tagdata
endfunction


function! TestFunction()
	let l:starttagstart = SearchEnclosingTag()[0]
	let l:starttagend = searchpos(s:opentagpattern, 'cWe')
	echo GetTagData(l:starttagstart, l:starttagend)
endfunction

