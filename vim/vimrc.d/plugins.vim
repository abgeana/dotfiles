" mark
if FileIsPresent('mark.vim')
    " use a proper palette
    let g:mwDefaultHighlightingPalette = 'maximum'
    " if the mark plugin is available use it together with
    " the regular search highlighting
    map <F1> <Leader>m
    map <F2> :setl hlsearch<CR>#*
    map <F3> :setl hlsearch!<CR>
    map <F4> :MarkClear<CR>:setl nohlsearch<CR>
else
    " if the plugin is not available, use only search highlighting
    map <F1> :setl hlsearch<CR>#*
    map <F2> :setl hlsearch!<CR>
endif

" nerdtree
if FileIsPresent('nerdtree.vim')
    let g:NERDTreeMinimalUI=1
    let g:NERDTreeShowLineNumbers=1
    " the ^[ is an escape character and may be typed by pressing ctrl+v and then alt+key
    set <m-x>=x
    map <m-x> :NERDTreeToggle<CR>
endif

" clang format
if filereadable('/usr/share/vim/addons/syntax/clang-format-3.5.py')
    set <m-f>=f
    map <m-f> :pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
    imap <m-f> <c-o>:pyf/usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
endif
