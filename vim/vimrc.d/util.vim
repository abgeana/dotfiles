" function which checks if a certain script is present
function FileIsPresent(path)
    let l:path = a:path
    if l:path[0] == '~'
        let l:path = $HOME . l:path[1:]
    endif
    return filereadable(l:path)
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

" function and command which simply clones the
" git repository of the vundle plugin manager
function VundleGitCloneFunc()
    !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
endfunction
command VundleGitClone call VundleGitCloneFunc()

" function which sets up vim and the buffer contents
" to be used with the tmux capture-pane command
function TmuxCapturePaneSetup()
    " be able to exit vim quickly
    cnoremap q q!
    " copy directly to the clipboard
    vnoremap y "+y
    " hide the status line
    set laststatus=0

    " go to the end of the buffer
    normal G
    " go to the beginning of the line
    normal 0
    " remove all lines which are empty
    while getline('.') == ''
        normal dd
    endwhile

    " scroll the last line to the bottom of the screen
    normal zb
endfunction
