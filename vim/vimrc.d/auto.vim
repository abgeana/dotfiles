" remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" make all buffers in all windows
autocmd BufWinEnter * :set relativenumber number
