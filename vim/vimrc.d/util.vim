" function which checks if a certain script is present
function FileIsPresent(script)
    for dir in split( &rtp, ',' )
        if isdirectory(dir)
            for file in split( system('find ' . dir . ' -type f'), ' ' )
                if file =~ ('.*/' . a:script)
                    return 1
                endif
            endfor
        endif
    endfor
    return 0
endfunction

" function used to get the visual selection
" https://stackoverflow.com/questions/1533565
function GetVisualSelection()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1: 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endfunction

" function which improves searching for a the word under the in
" normal mode cursor or a selected text snippet in visual mode
" there needs to be a way to tell the function if we are in visual mode
" https://vi.stackexchange.com/questions/8789
" https://vi.stackexchange.com/questions/8335
function DoSearch(visual)
    if a:visual
        normal! gv
    endif

    let l:current_mode = mode()

    if l:current_mode == 'n'
        let @/ = expand("<cword>")
    elseif l:current_mode == 'v'
        let @/ = GetVisualSelection()
    endif
endfunction
