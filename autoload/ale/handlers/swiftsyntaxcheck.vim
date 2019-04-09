" Author: tokorom https://github.com/tokorom
" Description: Handle errors for swift-syntax-check

function! ale#handlers#swiftsyntaxcheck#HandleOutput(buffer, lines) abort
    let l:pattern = '\v^([a-zA-Z]?:?[^:]+):(\d+):(\d+)?:? ([^:]+): (.+)$'
    let l:output = []

    for l:line in a:lines
        let l:match = matchlist(l:line, l:pattern)
        if empty(l:match) && !empty(l:output)
            let l:item = l:output[-1]
            let l:text = l:item.text
            let l:item.text = l:text . "\n" . l:line
            let l:detail = l:item.detail
            if type(l:detail) == type([])
              let l:item.detail = add(l:detail, l:line)
            else
              let l:item.detail = [l:detail, l:line]
            endif
        elseif !empty(l:match)
            let l:item = {
            \   'lnum': str2nr(l:match[2]),
            \   'text': l:match[5],
            \   'detail': l:match[5],
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
                let l:item.detail = l:code_match[1]
                let l:item.code = l:code_match[2]
            endif

            call add(l:output, l:item)
        endif
    endfor

    return l:output
endfunction
