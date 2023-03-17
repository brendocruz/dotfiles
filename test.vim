
function! SearchMathingTag(tagname)
	let l:tagstart = '\v\<\s*' . a:tagname . '\s*([^\>])*\s*\>'
	let l:tagend   = '\v\<\s*\/\s*'. a:tagname . '\s*\>\zs'
	let l:flags    = 'nWb'

	" \v\<\s*span\s*([^\>])*\s*\>
	" \v\<\s*\/\s*span\s*\>
	return searchpairpos(l:tagstart, '', l:tagend, l:flags)
endfunction


fu! NotMineSearchForMatchingTag(tagname, forwards)
    "returns the position of a matching tag or [0 0]

    let starttag = '\V<'.escape(a:tagname, '\').'\%(\_s\%(\.\{-}\|\_.\{-}\%<'.line('.').'l\)/\@<!\)\?>'
    let midtag = ''
    let endtag = '\V</'.escape(a:tagname, '\').'\_s\*'.(a:forwards?'':'\zs').'>'
    let flags = 'nW'.(a:forwards?'':'b')

    " When not in a string or comment ignore matches inside them.
    let skip ='synIDattr(synID(line("."), col("."), 0), "name") ' .
                \ '=~?  "\\%(html\\|xml\\)String\\|\\%(html\\|xml\\)CommentPart"'
    if skip | let skip = 0 | endif

    " Limit the search to lines visible in the window.
    let stopline = a:forwards ? line('w$') : line('w0')
    let timeout = 300

    " The searchpairpos() timeout parameter was added in 7.2
    if v:version >= 702
        return searchpairpos(starttag, midtag, endtag, flags, skip, stopline, timeout)
    else
        return searchpairpos(starttag, midtag, endtag, flags, skip, stopline)
    endif
endfu

" \<[\n\t\r ]*\w*[\n\t\r ]*(\w+\=[\w\d\-\"]+[\n\t\r ]*)*[\n\t\r ]*\>
"
"
" REGEX TO XML AND HTML ATTRIBUTE
" [a-zA-Z]+[\w\-]+\=((([\'\"]){1}\S+\3{1})|[\w\-]+|\{\S+\})
" REGEX TO HTML OPEN TAG
" \<\s*\w+\s*([^\>])*\s*\>
" REGEX TO HTML CLOSE TAG
" \<\s*\/\s*[\w\-]+\s*\>
