" Author: tokorom https://github.com/tokorom
" Description: handle swift-syntax-check (https://github.com/tokorom/swift-syntax-check)

call ale#linter#Define('swift', {
\   'name': 'swiftsyntaxcheck',
\   'executable': 'swift-syntax-check',
\   'command': 'swift-syntax-check %s',
\   'callback': 'ale#handlers#swiftsyntaxcheck#HandleOutput',
\})
