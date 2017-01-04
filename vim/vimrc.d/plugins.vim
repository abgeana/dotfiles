" mark
if FileIsPresent('mark.vim')
    " use a proper palette
    let g:mwDefaultHighlightingPalette = 'maximum'
    " if the mark plugin is available use it together with
    " the regular search highlighting
    map <F1> <Leader>m
    map <F2> :setl hlsearch<CR>:let @/ = expand("<cword>")<CR>
    map <F3> :setl hlsearch!<CR>
    map <F4> :MarkClear<CR>:setl nohlsearch<CR>
else
    " if the plugin is not available, use only search highlighting
    map <F1> :setl hlsearch<CR>:let @/ = expand("<cword>")<CR>
    map <F2> :setl hlsearch!<CR>
endif

" nerdtree
if FileIsPresent('nerdtree.vim')
    " do not display header
    let g:NERDTreeMinimalUI=1
    " show line numbers in the file viewer
    let g:NERDTreeShowLineNumbers=1
    " make splits behave same as with ctrl-w
    let g:NERDTreeMapOpenSplit='s'
    let g:NERDTreeMapOpenVSplit='v'
    " the ^[ is an escape character and may be typed by pressing ctrl+v and then alt+key
    set <m-x>=x
    map <m-x> :NERDTreeToggle<CR>
endif

" sneak
if FileIsPresent('sneak.vim')
    let g:sneak#streak = 1
    let g:sneak#s_next = 1
    let g:sneak#use_ic_scs = 1
endif

" easymotion
if FileIsPresent('EasyMotion.vim')
    " easiest way to get these is to look at colors displayed in
    " :so $VIMRUNTIME/syntax/hitest.vim
    hi link EasyMotionTarget        Title
    hi link EasyMotionShade         Comment
    hi link EasyMotionTarget2First  Question
    hi link EasyMotionTarget2Second MatchParen
    hi link EasyMotionMoveHL        Search
endif

" taglist
if FileIsPresent('taglist.vim')
    let g:Tlist_Use_Right_Window = 1
    let g:Tlist_WinWidth = 60
    let g:Tlist_Sort_Type = "name"
endif

" clang format
if filereadable('/usr/share/vim/addons/syntax/clang-format-3.5.py')
    set <m-f>=f
    map <m-f> :pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
    imap <m-f> <c-o>:pyf/usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
endif
