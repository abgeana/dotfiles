if empty(glob('~/.config/nvim/autoload/plug.vim')) == 0
    call plug#begin('~/.config/nvim/plugged')

    Plug 'google/vim-maktaba'           " dependency for vim-codefmt
    Plug 'inkarkat/vim-ingo-library'    " dependency for vim-mark
    Plug 'godlygeek/tabular'            " dependency for vim-markdown
    Plug 'prabirshrestha/async.vim'     " dependency for vim-lsp

    Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

    " fzf integration
    Plug '/usr/share/nvim/site/plugin/fzf.vim'      " instead of cloning the fzf repo for a file
    Plug 'junegunn/fzf.vim'

    Plug 'altercation/vim-colors-solarized'
    Plug 'justinmk/vim-sneak'
    Plug 'zhimsel/vim-stay'                         " persistent editing state; originally kopischke/vim-stay
    Plug 'wsdjeg/vim-fetch'                         " line and column in file name; originally kopischke/vim-fetch
    Plug 'google/vim-codefmt'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'alegen/vim-mark'                          " background coloring of arbitrary strings
    Plug 'inkarkat/vim-DeleteTrailingWhitespace'
    Plug 'inkarkat/vim-SyntaxRange'                 " use different syntax highlighting for arbitrary ranges
    Plug 'scrooloose/nerdtree'
    Plug 'majutsushi/tagbar'

    " language syntax plugins
    Plug 'plasticboy/vim-markdown'
    Plug 'PProvost/vim-ps1'                 " powershell
    Plug 'dart-lang/dart-vim-plugin'
    " Plug 'matze/vim-meson'
    " Plug 'HerringtonDarkholme/yats.vim'   " typescript
    " Plug 'udalov/kotlin-vim'
    " Plug 'keith/swift.vim'
    " Plug 'alegen/vim-smali'
    " Plug 'LnL7/vim-nix'
    " Plug 'nfnty/vim-nftables'

    call plug#end()
endif

" vim-plug automatically calls 'filetype indent on'
" https://github.com/junegunn/vim-plug#usage
filetype indent off " disable loading indent files for specific file types
