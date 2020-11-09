" allow buffers with changes to be hidden
" http://usevim.com/2012/10/19/vim101-set-hidden/
set hidden

" disable the mouse completely
set mouse=

" use manual folding and show the fold column
set foldmethod=manual
set foldcolumn=1

" backspace behaviour
" http://vim.wikia.com/wiki/Erasing_previously_entered_characters_in_insert_mode
set backspace=indent,eol,start

" dynamic indentation configuration
function IndentWidthFunc(local, width)
    if (a:local == 0)
        let &tabstop=a:width        " control the number of space chars inserted when TAB is pressed
        let &shiftwidth=a:width     " the number of space characters inserted for indentation
        let &softtabstop=a:width    " stop at multiple of 4 when pressing TAB key
    else
        let &l:tabstop=a:width      " control the number of space chars inserted when TAB is pressed
        let &l:shiftwidth=a:width   " the number of space characters inserted for indentation
        let &l:softtabstop=a:width  " stop at multiple of 4 when pressing TAB key
    endif
endfunction
command -nargs=1 IndentWidth call IndentWidthFunc(0, <f-args>)
command -nargs=1 IndentWidthLocal call IndentWidthFunc(1, <f-args>)

" set indentation to 4 spaces
IndentWidth 4

" insert space chars whenever TAB is pressed
set expandtab

" autoindentation
set autoindent
set smartindent
set nocindent

" searching
set incsearch               " incremental search
set ignorecase              " search ignoring case
set smartcase               " do not ignore case if text has one capital letter
set nohlsearch              " start without highlighting the search item
set showmatch               " show matching bracket
set diffopt=filler,iwhite   " ignore all whitespace and sync

" show hybdrid line numbers (number and relativenumber)
set number
set relativenumber

" shows what you are typing as a command
set showcmd

" remember more undos
set undolevels=2000

" no bells
set noerrorbells

" make a useful status line
set statusline=[\ buffer\ %n\ ]\ %F\ [%Y,%{&ff}]\ %m%r%h%=[\ %l/%L\ ,\ %v,\ %o\ ][\ %p%%\ ]

" always show the status line
set laststatus=2

" we have a fast terminal
set ttyfast

" avoid problems with esc key and meta key bindings
" <esc>+key will be the same as <alt>+key if the delay between pressing <esc>
" and key is less than the value in timeoutlen
set timeout
set nottimeout
set timeoutlen=200

" highlight the line on which the cursor is
set cursorline

" when more than one match, list all matches and complete till longest common string
set wildmenu

" complete only up to point of ambiguity
set wildmode=longest:full

" configure the completion menu
" menuone - use the popup menu also when there is only one match
" longest - only insert the longest common text of the matches
set completeopt=menuone,longest

" do not redraw too much
set lazyredraw

" shada (SHAred DAta) configuration
" default shada=!,'100,<50,s10,h
" '1000     - 1000 files for which you have marks (a-z)
" f1        - store global marks (A-Z and 0-9)
" <500      - lines saved for each of the registers
" h         - disable 'hlsearch' highlighting when starting
set shada='500,f1,<500,h

" show unprintable characters hexadecimal as <xx> instead of using ^C and ~C
set display=uhex
