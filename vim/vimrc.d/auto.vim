" make all buffers in all windows
autocmd BufWinEnter * :set relativenumber number

" run setlocal conceallevel=2 for markdown files
" this works very well with the plasticboy/vim-markdown plugin
autocmd FileType markdown setlocal conceallevel=2
