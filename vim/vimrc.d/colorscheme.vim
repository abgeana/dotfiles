" set the colorscheme
set background=dark

if has('unix') && FileIsPresent('~/.vim/bundle/vim-colors-solarized/colors/solarized.vim')
    colorscheme solarized
elseif has('win32') && FileIsPresent('~/.vim/bundle/neovim-colors-solarized-truecolor-only/colors/solarized.vim')
    colorscheme solarized
else
    colorscheme darkblue
    autocmd ColorScheme darkblue highlight Normal ctermbg=8
endif
