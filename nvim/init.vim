source ~/.config/nvim/init.vim.d/util.vim

source ~/.config/nvim/init.vim.d/init.vim

for file in split( globpath('~/.config/nvim/init.vim.d/', '*.vim') )
    if file !~ '.*util.vim$' && file !~ '.*init.vim$' && file !~ '.*final.vim$'
        exec 'source ' . file
    endif
endfor

source ~/.config/nvim/init.vim.d/final.vim
