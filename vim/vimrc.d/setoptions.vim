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
set expandtab       " insert space chars whenever TAB is pressed
set tabstop=4       " control the number of space chars inserted when TAB is pressed
set shiftwidth=4    " the number of space characters inserted for indentation
set softtabstop=4   " stop at multiple of 4 when pressing TAB key
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
if FileIsPresent('fugitive.vim')
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
