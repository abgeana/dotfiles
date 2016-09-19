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

" pathogen ( required for future configs, needs to be in init.vim )
if FileIsPresent('vundle.vim')
    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'
    " nerdtree file viewer
    Plugin 'scrooloose/nerdtree'
    " solarized color scheme
    Plugin 'altercation/vim-colors-solarized'
    " bookmarks and tags in files
    Plugin 'MattesGroeger/vim-bookmarks'
    " unite magic
    Plugin 'Shougo/unite.vim'

    call vundle#end()
endif
