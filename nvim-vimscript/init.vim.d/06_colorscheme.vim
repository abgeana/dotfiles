set background=dark

if empty(glob('~/.config/nvim/plugged/vim-colors-solarized/colors/solarized.vim')) == 0
    autocmd colorscheme solarized highlight colorcolumn ctermbg=1
    colorscheme solarized
else
    autocmd colorscheme darkblue highlight normal ctermbg=8
    colorscheme darkblue
endif
