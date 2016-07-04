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
    return join(lines, '\n')
endfunction

function s:utfcodes(text)
    let chars = split(a:text, '\zs')
    let i = 0
    let newtext = ''

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

    if lnum1 != lnum2
        echo 'Script does not work for text over multiple lines.'
        return
    endif

    let text = s:getText(lnum1, col1, lnum2, col2)
    let utf = s:utfcodes(text)
    let line = getline(lnum1)

    " -1 because it is inclusive (unlike python) and -1 because coords index start at 1
    let split1 = col1 - 1 - 1
    " getSelectionCoords already puts col2 to the last byte of the last character!
    let split2 = col2 - (&selection == 'inclusive' ? 1 : 2) + 1
    " next if is required if we change the first character in a line
    if split1 >= 0
        let line = line[: split1 ] . utf . line[ split2 :]
    else
        let line = utf . line[ split2 :]
    endif
    call setline(lnum1, line)
endfunction

function NormalReplace()
    let text = s:characterUnderCursor()
    let utf = s:utfcodes(text)

    " get coords of the cursor
    let curcoords = getpos('.')[1:2]
    " calculate the x coordonate where the split occurs
    " -1 because it is inclusive (unlike python) and -1 because coords index start at 1
    let splitcoord = curcoords[1] - 1 - 1
    " change the line contents
    let line = getline('.')
    " next if is required if we change the first character in a line
    if splitcoord >= 0
        " +1 because coords are 1 based
        let line = line[: splitcoord ] . utf . line[ splitcoord + 1 + len(text) :]
    else
        let line = utf . line[ len(text) :]
    endif
    call setline('.', line)
endfunction

" for the mapping in visual mode, the backspaces are required
" to remove the range that is printed when going to the command line
vmap <C-z> :<BS><BS><BS><BS><BS>call VisualReplace()<CR>
nmap <C-z> :call NormalReplace()<CR>
