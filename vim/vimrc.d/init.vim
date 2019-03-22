" vim plugins
if empty(glob('~/.config/nvim/autoload/plug.vim')) == 0
    call plug#begin('~/.config/nvim/plugged')

    Plug 'google/vim-maktaba'           " dependency for vim-codefmt
    Plug 'inkarkat/vim-ingo-library'    " dependency for vim-mark
    Plug 'godlygeek/tabular'            " dependency for vim-markdown

    Plug 'alegen/DeleteTrailingWhitespace.vim'
    Plug 'alegen/vim-mark'      " fancy colors
    Plug 'justinmk/vim-sneak'   " easier motions
    Plug 'zhimsel/vim-stay'     " persistent editing state; originally kopischke/vim-stay
    Plug 'wsdjeg/vim-fetch'     " line and column in file name; originally kopischke/vim-fetch
    Plug 'google/vim-codefmt'

    Plug 'Shougo/denite.nvim'
    Plug 'junegunn/fzf.vim'
    Plug 'alegen/nerdtree'
    Plug 'majutsushi/tagbar'

    Plug 'plasticboy/vim-markdown'
    Plug 'lervag/vimtex'
    "Plug 'alegen/vim-smali'
    "Plug 'udalov/kotlin-vim'
    "Plug 'keith/swift.vim'

    " solarized color scheme
    if has('unix')
        Plug 'altercation/vim-colors-solarized'
    elseif has('win32')
        Plug 'frankier/neovim-colors-solarized-truecolor-only'
    endif

    " lsp client
    " https://github.com/autozimu/LanguageClient-neovim#quick-start
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }

    call plug#end()
endif
