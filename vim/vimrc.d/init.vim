" if this is neovim, set the runtimepath to include (some) regular vim directories
if has('nvim')
    let &rtp = &rtp . ',/var/lib/vim/addons'
endif

" add the bundle directory to the path for vundle.vim
let &rtp = &rtp . ',~/.vim/bundle'

" some websites say that pathogen and other plugins require this
filetype off

" be VImproved and not just VI
set nocompatible

" define the leader to space
let mapleader="\<Space>"

" vundle plugins
if FileIsPresent('~/.vim/bundle/Vundle.vim/autoload/vundle.vim')
    " set the runtime path to include vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let vundle manage vundle, required (needs to be first)
    " to install vundle, run the following command
    " git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    " or simply use the VundleGitClone command
    Plugin 'VundleVim/Vundle.vim'

    " section with plugins from my own repositories (or mirrors/forks)
    " nerdtree file viewer
    Plugin 'alegen/nerdtree'
    " my own version of mark.vim for fancy colors
    Plugin 'alegen/mark.vim'
    " my own mirror of cscope_maps.vim
    " currently replaced by the GNU GLOBAL plugin
    "Plugin 'alegen/vim-cscope-maps'
    " ability to interpret ansi escape color sequences
    Plugin 'alegen/AnsiEsc.vim'
    " delete trailing whitespaces; this is better than the "autocmd" line
    " since it does not move the cursor when saving a file
    " https://stackoverflow.com/questions/35390415
    Plugin 'alegen/DeleteTrailingWhitespace.vim'
    " smali syntax highlighting
    Plugin 'alegen/vim-smali'

    " section with plugins from repositories maintained by other people
    " solarized color scheme
    if has('unix')
        Plugin 'altercation/vim-colors-solarized'
    elseif has('win32')
        Plugin 'frankier/neovim-colors-solarized-truecolor-only'
    endif
    " unite magic
    Plugin 'Shougo/unite.vim'
    " automatic session management
    Plugin 'tpope/vim-obsession'
    " markdown helper
    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'
    " easier motions
    Plugin 'easymotion/vim-easymotion'
    Plugin 'justinmk/vim-sneak'
    " persistent editing state (views, cursos position, folds, etc.)
    " originally kopischke/vim-stay
    Plugin 'zhimsel/vim-stay'
    " handle line and column numbers within file names
    " originally kopischke/vim-fetch
    Plugin 'wsdjeg/vim-fetch'
    " code formatting plugin
    Plugin 'google/vim-maktaba'
    Plugin 'google/vim-codefmt'
    " GNU GLOBAL plugin
    Plugin 'vim-scripts/gtags.vim'

    " support for the additional languages and file types
    Plugin 'arrufat/vala.vim'
    Plugin 'udalov/kotlin-vim'
    Plugin 'keith/swift.vim'

    if FileIsPresent('/usr/bin/ctags-exuberant')
        " tags listing on the side
        Plugin 'vim-scripts/taglist.vim'
    endif

    if FileIsPresent('/usr/local/bin/vifm')
        " vifm madness
        Plugin 'vifm/vifm.vim'
    endif

    call vundle#end()
endif
