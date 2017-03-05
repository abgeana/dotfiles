" set the colorscheme
set background=dark

if FileIsPresent('~/.vim/bundle/vim-colors-solarized/colors/solarized.vim')
    colorscheme solarized
else
    colorscheme darkblue
    autocmd ColorScheme darkblue highlight Normal ctermbg=8
endif
