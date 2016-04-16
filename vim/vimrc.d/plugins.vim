" nerdtree
if FileIsPresent('nerdtree.vim')
    let g:NERDTreeMinimalUI=1
    map <C-z> :NERDTreeToggle<CR>
endif

" mark
if FileIsPresent('mark.vim')
    let g:mwDefaultHighlightingPalette = 'maximum'
endif

" clang format
if filereadable('/usr/share/vim/addons/syntax/clang-format-3.7.py')
    map <C-f> :pyf /usr/share/vim/addons/syntax/clang-format-3.7.py<CR>
    imap <C-f> <c-o>:pyf/usr/share/vim/addons/syntax/clang-format-3.7.py<CR>
endif
