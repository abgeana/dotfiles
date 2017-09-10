" make a better tab line
" http://stackoverflow.com/questions/7237416
set tabline=%!GetTabLine()

function GetTabLine()
    let s = ''
    " the number of tabs
    let nrtabs = tabpagenr('$')
    " the 0 based index of the active tab
    let tabidx = tabpagenr() - 1

    " generate the left and right sides of the tab line from the number of
    " columns, subtract 2 * 7 for tab line start and end strings (' DD << '
    " and ' >> DD '); also subtract the length of the active tab
    let maxsidelen = (&columns - ( 2 * 7 + GetTabLabelLength(tabidx) )) / 2

    " try to add tab labels to the left until all have been added or there is
    " no more space left
    let leftlen = maxsidelen
    let leftidx = tabidx - 1
    while leftidx >= 0 && leftlen - GetTabLabelLength(leftidx) >= 0
        let leftlen -= GetTabLabelLength(leftidx)
        let leftidx -= 1
    endwhile

    "" try to add tab labels to the right until all have been added or there is
    "" no more space left
    let rightlen = maxsidelen
    let rightidx = tabidx + 1
    " if leftidx == -1, then we can use remainng space from leftlen
    if leftidx == -1
        let rightlen += leftlen
    endif
    while rightidx <= nrtabs - 1 && rightlen - GetTabLabelLength(rightidx) >= 0
        let rightlen -= GetTabLabelLength(rightidx)
        let rightidx += 1
    endwhile

    " try to add tab labels to the left, in case there is some space and more
    " tabs to the left remaining
    if rightlen > 0 && leftidx >= 0
        let leftlen += rightlen
        while leftidx >= 0 && leftlen - GetTabLabelLength(leftidx) >= 0
            let leftlen -= GetTabLabelLength(leftidx)
            let leftidx -= 1
        endwhile
    endif

    let leftidx += 1
    let rightidx -= 1

    " make a string with tab labels from leftidx to rightidx, inclusive
    let s = ''
    let srawlen = 0
    for i in range(leftidx, rightidx)
        if i == tabidx
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        let s .= GetTabLabel(i)
        let srawlen += GetTabLabelLength(i)
    endfor

    " after the last tab fill with TabLineFill
    let s .= '%#TabLineFill#%T'

    " calculate padding to keep the start and end strings in the same location
    let padlen = &columns - (2 * 7 + srawlen)
    let s = printf(' %2d << ', leftidx) . s
    let s .= repeat(' ', padlen) . printf(' >> %2d ', nrtabs - rightidx - 1)

    return s
endfunction

" this function gets the raw label for a tab (i.e. without the tab number)
" the function takes as argument the 0 based index of the tab to return the
" raw label for
function GetRawLabel(n)
    " get the indices of the buffers in the current tab
    let buflist = tabpagebuflist(a:n + 1)
    " get the index of the active window in tab a:n
    let winnr = tabpagewinnr(a:n + 1)
    " get the index of the buffer in the active window
    let bufidx = buflist[winnr - 1]
    " get the label of the buffer in the active window
    let buflabel =  bufname(bufidx)
    " get the tail of the file name
    return fnamemodify(buflabel, ":t")
endfunction

" this function returns the final label for a tab
" the function takes as argument the 0 based index of the tab to return the
" label for
function GetTabLabel(n)
    let rawlabel = GetRawLabel(a:n)
    return ' [' . printf('%d', a:n + 1) . ']' . rawlabel . ' '
endfunction

" this function returns the length of the tab label as it appears in the final
" tab line; this function takes as argument the 0 based index of the tab
function GetTabLabelLength(n)
    return len( GetTabLabel(a:n) )
endfunction
