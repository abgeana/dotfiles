" map vs. remap vs. noremap - http://stackoverflow.com/questions/3776117

" define the leader to space
let mapleader=","

" to disable autoindentation and autocommenting press F3, to enable it back press F4
map <F5> :set formatoptions-=cro nocindent noautoindent nosmartindent inde=<CR>
map <F6> :set formatoptions+=cro nocindent autoindent smartindent inde=    <CR>

" move cursor on wrapped lines
noremap <silent> <A-k> gk
noremap <silent> <A-j> gj

" move the complete window
noremap <silent> <A-S-k> <C-y>
noremap <silent> <A-S-j> <C-e>

" improve the vim completion menu with some custom remappings
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" change the behavior of the enter key when the completion popup menu is visible to select the entry
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" let me keep typing and enter selects the entry directly
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
    \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" mapping to call the YankLocation() function defined in util.vim
nnoremap yl :call YankLocation()<CR>

" remap gf to open a file under the cursor and with line number
nnoremap gf gF

" remap <Leader><Esc> to <C-\><C-n> for neovim
" see also ":help terminal" or ":help CTRL-\_CTRL-N"
tnoremap <Leader><Leader> <C-\><C-n>
