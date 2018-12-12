" set the colorscheme
set background=dark

if has('unix') && empty(glob('~/.config/nvim/plugged/vim-colors-solarized/colors/solarized.vim')) == 0
    colorscheme solarized
elseif has('win32') && empty(glob('~/.config/nvim/plugged/neovim-colors-solarized-truecolor-only/colors/solarized.vim')) == 0
    colorscheme solarized
else
    colorscheme darkblue
    autocmd ColorScheme darkblue highlight Normal ctermbg=8
endif
