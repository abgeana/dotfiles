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

" function which checks if a certain script is present
function FileIsPresent(script)
    for dir in split( &rtp, ',' )
        if isdirectory(dir)
            for file in split( system('find ' . dir . ' -type f'), ' ' )
                if file =~ ('.*/' . a:script)
                    return 1
                endif
            endfor
        endif
    endfor
    return 0
endfunction

" vundle plugins
if FileIsPresent('vundle.vim')
    " set the runtime path to include vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let vundle manage vundle, required
    Plugin 'VundleVim/Vundle.vim'
    " nerdtree file viewer
    Plugin 'scrooloose/nerdtree'
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

    call vundle#end()
endif
