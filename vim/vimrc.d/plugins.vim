" mark
if FileIsPresent('~/.vim/bundle/mark.vim/plugin/mark.vim')
    " use a proper palette
    let g:mwDefaultHighlightingPalette = 'maximum'
    " if the mark plugin is available use it together with
    " the regular search highlighting
    map <F1> <Leader>m
    nnoremap <F2> :call DoSearch(0)<CR>:setl hlsearch<CR>
    vnoremap <F2> :call DoSearch(1)<CR><Esc>:setl hlsearch<CR>
    map <F3> :setl hlsearch!<CR>
    map <F4> :MarkClear<CR>:setl nohlsearch<CR>
else
    " if the plugin is not available, use only search highlighting
    map <F1> :setl hlsearch<CR>:let @/ = expand("<cword>")<CR>
    map <F2> :setl hlsearch!<CR>
endif

" nerdtree
if FileIsPresent('~/.vim/bundle/nerdtree/plugin/NERD_tree.vim')
    " do not display header
    let g:NERDTreeMinimalUI=1
    " show line numbers in the file viewer
    let g:NERDTreeShowLineNumbers=1
    " make splits behave same as with ctrl-w
    let g:NERDTreeMapOpenSplit='s'
    let g:NERDTreeMapOpenVSplit='v'

    if has('nvim') == 0
        map x :NERDTreeToggle<CR>
    else
        map <A-x> :NERDTreeToggle<CR>
    endif
endif

" sneak
if FileIsPresent('~/.vim/bundle/vim-sneak/plugin/sneak.vim')
    let g:sneak#streak = 1
    let g:sneak#s_next = 1
    let g:sneak#use_ic_scs = 1
endif

" easymotion
if FileIsPresent('~/.vim/bundle/vim-easymotion/plugin/EasyMotion.vim')
    " easiest way to get these is to look at colors displayed in
    " :so $VIMRUNTIME/syntax/hitest.vim
    hi link EasyMotionTarget        Title
    hi link EasyMotionShade         Comment
    hi link EasyMotionTarget2First  Question
    hi link EasyMotionTarget2Second MatchParen
    hi link EasyMotionMoveHL        Search
endif

" taglist
if FileIsPresent('~/.vim/bundle/taglist.vim/plugin/taglist.vim')
    let g:Tlist_Use_Right_Window = 1
    let g:Tlist_WinWidth = 60
    let g:Tlist_Sort_Type = "name"
endif

" vim-markdown
if FileIsPresent('~/.vim/bundle/vim-markdown/ftplugin/markdown.vim')
    let g:vim_markdown_folding_disabled = 1
endif

" DeleteTrailingWhitespace
if FileIsPresent('~/.vim/bundle/DeleteTrailingWhitespace.vim/plugin/DeleteTrailingWhitespace.vim')
    " i want to eradicate all trailing spaces all the time
    let g:DeleteTrailingWhitespace = 1
    " automatically do it for me when i save a file
    let g:DeleteTrailingWhitespace_Action = 'delete'
endif

" clang format
if filereadable('/usr/share/vim/addons/syntax/clang-format-3.5.py')
    set <m-f>=f
    map <m-f> :pyf /usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
    imap <m-f> <c-o>:pyf/usr/share/vim/addons/syntax/clang-format-3.5.py<CR>
endif

