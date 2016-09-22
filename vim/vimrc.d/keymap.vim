" map vs. remap vs. noremap - http://stackoverflow.com/questions/3776117

if FileIsPresent('mark.vim')
    " if the mark plugin is available use it together with
    " the regular search highlighting
    map <F1> <Leader>m
    map <F2> :setl hlsearch<CR>#*
    map <F3> :setl hlsearch!<CR>
    map <F4> :MarkClear<CR>:setl nohlsearch<CR>
else
    " if the plugin is not available, use only search highlighting
    map <F1> :setl hlsearch<CR>#*
    map <F2> :setl hlsearch!<CR>
endif

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
cnoremap w!! w !sudo tee > /dev/null %
