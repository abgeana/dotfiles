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

" function and command which install vim-plug
" https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation
function VimPlugInstallFunc()
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        echomsg 'installed vim-plug'
    else
        echomsg 'vim-plug is already installed'
    endif
endfunction
command VimPlugInstall call VimPlugInstallFunc()

" function which sets up vim and the buffer contents
" to be used with the tmux capture-pane command
function TmuxCapturePaneSetup()
    " be able to exit vim quickly
    noremap q :q!<CR>
    " copy directly to the clipboard
    vnoremap y "+y
    " hide the status line
    set laststatus=0

    " go to the beginning of the buffer
    normal 0gg
    " remove all lines which are empty
    while getline('.') == ''
        normal dd
    endwhile

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

" function to get the full path of the file in the current buffer with the
" location of the cursor in the buffer; the information is placed into the
" clipboard
function YankLocation()
    " get the path of the file in the current buffer
    let fpath = expand('%:p')
    " append the location of the cursor
    let fpath = fpath . ':' . line('.') . ':' . col('.')
    " place it in the clipboard
    let @+ = fpath
endfunction
