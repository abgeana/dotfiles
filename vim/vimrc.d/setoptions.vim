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

" tabs and spaces
" dynamic configuration
let g:indent_width=4
function IndentWidthFunc(w)
    let g:indent_width=a:w
    let &tabstop=g:indent_width       " control the number of space chars inserted when TAB is pressed
    let &shiftwidth=g:indent_width    " the number of space characters inserted for indentation
    let &softtabstop=g:indent_width   " stop at multiple of 4 when pressing TAB key
endfunction
command -nargs=1 IndentWidth call IndentWidthFunc(<f-args>)
IndentWidth 4
set expandtab       " insert space chars whenever TAB is pressed
retab               " when opening a file, convert tab chars to spaces

" autoindentation
set autoindent
set smartindent
set nocindent

" searching
set incsearch               " incremental search
set ignorecase              " search ignoring case
set nohlsearch              " start without highlighting the search item
set showmatch               " show matching bracket
set diffopt=filler,iwhite   " ignore all whitespace and sync

" show hybdrid line numbers (number and relativenumber)
set number
set relativenumber

" shows what you are typing as a command
set showcmd

" 256 colors
set t_Co=256

" remember more undos
set undolevels=1000

" no bells
set noerrorbells

" make a useful status line
if FileIsPresent('~/.vim/bundle/vim-fugitive/plugin/fugitive.vim')
    set statusline=[\ buffer\ %n\ ]\ %F\ [%Y,%{&ff}]\ %m%r%h%=%{fugitive#statusline()}[\ %l/%L\ ,\ %v\ ][\ %p%%\ ]
else
    set statusline=[\ buffer\ %n\ ]\ %F\ [%Y,%{&ff}]\ %m%r%h%=[\ %l/%L\ ,\ %v\ ][\ %p%%\ ]
endif

" always show the status line
set laststatus=2

" we have a fast terminal
set ttyfast

" viewoptions suggested by the restore_view.vim plugin
set viewoptions=cursor,folds,slash,unix

" avoid problems with esc key and meta key bindings
" <esc>+key will be the same as <alt>+key if the delay between pressing <esc>
" and key is less than the value in timeoutlen
set timeout
set nottimeout
set timeoutlen=200

" highlight the line on which the cursor is
set cursorline

" show a visual menu of autocomplete options
set wildmenu

" do not redraw too much
set lazyredraw
