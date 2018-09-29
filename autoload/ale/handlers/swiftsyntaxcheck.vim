" Author: tokorom https://github.com/tokorom
" Description: Handle errors for swift-syntax-check

function! ale#handlers#swiftsyntaxcheck#HandleOutput(buffer, lines) abort
    let l:pattern = '\v^([a-zA-Z]?:?[^:]+):(\d+):(\d+)?:? ([^:]+): (.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        let l:item = {
        \   'lnum': str2nr(l:match[2]),
        \   'text': l:match[5],
        \}

        if l:match[4] is# 'error'
            let l:item.type = 'E'
        elseif l:match[4] is# 'note'
            let l:item.type = 'I'
        else
            let l:item.type = 'W'
        endif

        if !empty(l:match[3])
            let l:item.col = str2nr(l:match[3])
        endif

        " If the filename is something like <stdin>, <nofile> or -, then
        " this is an error for the file we checked.
        if l:match[1] isnot# '-' && l:match[1][0] isnot# '<'
            let l:item['filename'] = l:match[1]
        endif

        " Parse the code if it's there.
        let l:code_match = matchlist(l:item.text, '\v^(.+) \(([^ (]+)\)$')

        if !empty(l:code_match)
            let l:item.text = l:code_match[1]
            let l:item.code = l:code_match[2]
        endif

        call add(l:output, l:item)
    endfor

    return l:output
endfunction
