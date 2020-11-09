for file in split( globpath('~/.config/nvim/init.vim.d/', '*.vim') )
    exec 'source ' . file
endfor
