" make all buffers in all windows
autocmd BufWinEnter * :set relativenumber number

" run setlocal conceallevel=2 for markdown files
" this works very well with the plasticboy/vim-markdown plugin
autocmd FileType markdown setlocal conceallevel=2

" set indentation of 2 spaces for yaml files
autocmd FileType yaml IndentWidth 2

" start terminal buffers in insert mode
" https://github.com/neovim/neovim/pull/2076#issuecomment-76998265
" does not work because of some ordering bug; disabled for now
" https://github.com/neovim/neovim/issues/8691
"autocmd WinEnter *term:* call feedkeys('i')
