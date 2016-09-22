" nerdtree
if FileIsPresent('nerdtree.vim')
    let g:NERDTreeMinimalUI=1
    " the ^[ is an escape character and may be typed by pressing ctrl+v and then alt+key
    set <m-n>=n
    map <m-n> :NERDTreeToggle<CR>
endif

" mark
if FileIsPresent('mark.vim')
    let g:mwDefaultHighlightingPalette = 'maximum'
endif

" clang format
if filereadable('/usr/share/vim/addons/syntax/clang-format-3.5.py')
    map <A-f> :pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
    imap <A-f> <c-o>:pyf/usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
endif
