" if this is neovim, set the runtimepath to include (some) regular vim directories
if has('nvim')
    let &rtp = &rtp . ',/var/lib/vim/addons'
endif

" some websites say that pathogen and other plugins require this
filetype off

" define the leader to space
let mapleader="\<Space>"

" function which checks if a certain script is present
function FileIsPresent(script)
    for dir in split( &rtp, ',' )
        if isdirectory(dir)
            for file in split( system('find ' . dir . ' -type f'), ' ' )
                if file =~ ('.*' . a:script)
                    return 1
                endif
            endfor
        endif
    endfor
    return 0
endfunction

" pathogen ( required for future configs, needs to be in init.vim )
if FileIsPresent('pathogen.vim')
    execute pathogen#infect()
endif
