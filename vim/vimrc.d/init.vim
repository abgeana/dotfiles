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
if FileIsPresent('vundle.vim')
    " set the runtime path to include vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let vundle manage vundle, required
    " to install vundle, run the following command
    " git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    Plugin 'VundleVim/Vundle.vim'
    " nerdtree file viewer
    Plugin 'alegen/nerdtree'
    " solarized color scheme
    Plugin 'altercation/vim-colors-solarized'
    " bookmarks and tags in files
    Plugin 'MattesGroeger/vim-bookmarks'
    " unite magic
    Plugin 'Shougo/unite.vim'
    " vim git integration
    Plugin 'tpope/vim-fugitive'
    " automatic session management
    Plugin 'tpope/vim-obsession'
    " my own version of mark.vim for fancy colors
    Plugin 'alegen/mark.vim'
    " tags listing on the side
    Plugin 'vim-scripts/taglist.vim'
    " open a file at a specified line
    Plugin 'vim-scripts/file-line'
    " markdown helper
    Plugin 'godlygeek/tabular'
    Plugin 'plasticboy/vim-markdown'
    " easier motions
    Plugin 'easymotion/vim-easymotion'
    Plugin 'justinmk/vim-sneak'
    " vifm madness
    Plugin 'vifm/vifm.vim'
    " support for the vala language
    Plugin 'arrufat/vala.vim'
    " restore cursor position and folds
    Plugin 'vim-scripts/restore_view.vim'
    " my own mirror of cscope_maps.vim
    Plugin 'alegen/vim-cscope-maps'

    call vundle#end()
endif
