" map vs. remap vs. noremap - http://stackoverflow.com/questions/3776117

" to disable autoindentation and autocommenting press F3, to enable it back press F4
map <F5> :set formatoptions-=cro nocindent noautoindent nosmartindent inde=<CR>
map <F6> :set formatoptions+=cro nocindent autoindent smartindent inde=    <CR>

" enter command mode with ; instead of :
noremap ; q:i

" move cursor on wrapped lines
map <silent> <C-k> gk
map <silent> <C-j> gj

" use ctrl+[d,u] instead of ctrl+[f,b]
" this is mainly because tmux uses ctrl+b
noremap <C-d> <C-f>
noremap <C-u> <C-b>

" break the arrow keys habbit once and for all...
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" ability to sudo write to a file without opening vim as root
" http://stackoverflow.com/questions/2600783
cnoremap sw w !sudo tee > /dev/null %

" improve the vim completion menu with some custom remappings
" http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
" change the behavior of the enter key when the completion popup menu is visible to select the entry
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" let me keep typing and enter selects the entry directly
inoremap <expr> <C-n> pumvisible() ? '<C-n>' :
    \ '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
