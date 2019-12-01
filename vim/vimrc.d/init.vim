" vim plugins
if empty(glob('~/.config/nvim/autoload/plug.vim')) == 0
    call plug#begin('~/.config/nvim/plugged')

    Plug 'google/vim-maktaba'           " dependency for vim-codefmt
    Plug 'inkarkat/vim-ingo-library'    " dependency for vim-mark
    Plug 'godlygeek/tabular'            " dependency for vim-markdown
    Plug 'prabirshrestha/async.vim'     " dependency for vim-lsp

    Plug 'justinmk/vim-sneak'   " easier motions
    Plug 'zhimsel/vim-stay'     " persistent editing state; originally kopischke/vim-stay
    Plug 'wsdjeg/vim-fetch'     " line and column in file name; originally kopischke/vim-fetch
    Plug 'google/vim-codefmt'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'alegen/vim-mark'
    Plug 'inkarkat/vim-DeleteTrailingWhitespace'
    Plug 'inkarkat/vim-SyntaxRange'

    Plug 'Shougo/denite.nvim'
    Plug 'junegunn/fzf.vim'
    Plug 'majutsushi/tagbar'
    Plug 'scrooloose/nerdtree'

    "Plug 'prabirshrestha/vim-lsp'
    "Plug 'natebosch/vim-lsc'
    "Plug 'vim-scripts/gtags.vim'

    Plug 'plasticboy/vim-markdown'
    Plug 'nfnty/vim-nftables'
    Plug 'dart-lang/dart-vim-plugin'
    Plug 'HerringtonDarkholme/yats.vim'
    "Plug 'lervag/vimtex'
    "Plug 'udalov/kotlin-vim'
    "Plug 'keith/swift.vim'
    "Plug 'alegen/vim-smali'

    " solarized color scheme
    if has('unix')
        Plug 'altercation/vim-colors-solarized'
    elseif has('win32')
        Plug 'frankier/neovim-colors-solarized-truecolor-only'
    endif

    call plug#end()
endif

" enable syntax highlighting
filetype plugin on
filetype indent off
syntax enable
