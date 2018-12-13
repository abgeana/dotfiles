" vim plugins
if empty(glob('~/.config/nvim/autoload/plug.vim')) == 0
    call plug#begin('~/.config/nvim/plugged')

    " nerdtree file viewer
    Plug 'alegen/nerdtree'
    " my own version of vim-mark for fancy colors
    Plug 'inkarkat/vim-ingo-library'
    Plug 'alegen/vim-mark'
    " delete trailing whitespaces; this is better than the "autocmd" line
    " since it does not move the cursor when saving a file
    " https://stackoverflow.com/questions/35390415
    Plug 'alegen/DeleteTrailingWhitespace.vim'
    " smali syntax highlighting
    Plug 'alegen/vim-smali'

    " markdown helper
    Plug 'godlygeek/tabular'
    Plug 'plasticboy/vim-markdown'
    " easier motions
    Plug 'justinmk/vim-sneak'
    " persistent editing state (views, cursos position, folds, etc.)
    " originally kopischke/vim-stay
    Plug 'zhimsel/vim-stay'
    " handle line and column numbers within file names
    " originally kopischke/vim-fetch
    Plug 'wsdjeg/vim-fetch'
    " code formatting plugin
    Plug 'google/vim-maktaba'
    Plug 'google/vim-codefmt'
    " GNU GLOBAL plugin
    Plug 'vim-scripts/gtags.vim'

    " support for the additional languages and file types
    Plug 'udalov/kotlin-vim'
    Plug 'keith/swift.vim'

    " section with plugins from repositories maintained by other people
    " solarized color scheme
    if has('unix')
        Plug 'altercation/vim-colors-solarized'
    elseif has('win32')
        Plug 'frankier/neovim-colors-solarized-truecolor-only'
    endif

    " automatically executes
    "   filetype plugin indent on
    "   syntax enable
    call plug#end()
endif
