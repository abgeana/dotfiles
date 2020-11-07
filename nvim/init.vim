" if certain utility code is needed, then use the util.vim file
source ~/.config/nvim/vimrc.d/util.vim

" if certain configs need to be applied first, then apply them in the init.vim file
source ~/.config/nvim/vimrc.d/init.vim

for file in split( globpath('~/.config/nvim/vimrc.d/', '*.vim') )
    if file !~ '.*util.*' && file !~ '.*init.*' && file !~ '.*final.*'
        exec 'source ' . file
    endif
endfor

" if certain configs need to be applied last, then apply them in the final.vim file
source ~/.config/nvim/vimrc.d/final.vim
