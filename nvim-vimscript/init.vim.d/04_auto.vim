" make all buffers in all windows
autocmd BufWinEnter * :set relativenumber number

" set indentation of 2 spaces for yaml files
autocmd FileType yaml IndentWidth 2
