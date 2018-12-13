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
noremap <silent> <C-k> <C-y>
noremap <silent> <C-j> <C-e>

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

" mapping to call the YankLocation() function defined in util.vim
nnoremap yl :call YankLocation()<CR>

" remap gf to open a file under the cursor and with line number
nnoremap gf gF

" remap <Leader><Esc> to <C-\><C-n> for neovim
" see also ":help terminal" or ":help CTRL-\_CTRL-N"
tnoremap <Leader><Esc> <C-\><C-n>
