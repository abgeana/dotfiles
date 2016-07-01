function s:characterUnderCursor()
    " the code below is based on Ingo Karkat's answer on this thread
    " https://stackoverflow.com/questions/23323747
    let char = matchstr(getline('.'), '\%' . col('.') . 'c.')
    return char
endfunction

function s:characterAtCoords(lnum, col)
    " the code below is based on Ingo Karkat's answer on this thread
    " https://stackoverflow.com/questions/23323747
    let char = matchstr(getline(a:lnum), '\%' . a:col . 'c.')
    return char
endfunction

function s:getSelectionCoords()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lastchar = s:characterAtCoords(lnum2, col2)
    let col2 += len(lastchar) - 1
    return [lnum1, col1, lnum2, col2]
endfunction

function s:getText(lnum1, col1, lnum2, col2)
    " the code below is based on xolox's answer on this thread
    " https://stackoverflow.com/questions/1533565
    let lines = getline(a:lnum1, a:lnum2)
    let lines[-1] = lines[-1][: a:col2 - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][a:col1 - 1:]
    return join(lines, "\n")
endfunction

function s:utfcodes(text)
    let chars = split(a:text, '\zs')
    let i = 0
    let newtext = ""

    while i < len(chars)
        let c = chars[i]
        if i > 0
            let newtext .= '_'
        endif
        let newtext .= printf('%x', char2nr(c))
        let i += 1
    endwhile

    return newtext
endfunction

function VisualReplace()
    let [lnum1, col1, lnum2, col2] = s:getSelectionCoords()
    let text = s:getText(lnum1, col1, lnum2, col2)
    let text = s:utfcodes(text)
    return text
endfunction

function NormalReplace()
    " the code below is based on Ingo Karkat's answer on this thread
    " https://stackoverflow.com/questions/23323747
    let text = s:characterUnderCursor()
    let text = s:utfcodes(text)
    return text
endfunction

" for the mapping in visual mode, the backspaces are required
" to remove the range that is printed when going to the command line
vmap <C-z> :<BS><BS><BS><BS><BS>echo VisualReplace()<CR>
nmap <C-z> :echo NormalReplace()<CR>
