" tell vim to remember certain things when we exit
" http://vimdoc.sourceforge.net/htmldoc/usr_21.html#21.3
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  h    :  disable hlsearch highlighting when starting
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
if has('nvim')
    " this is the nvim version with extra stuff
    set viminfo='10,\"100,:20,h,%,n~/.nviminfo
else
    " this is the regular vim version to make sure it does not complain if
    " nvim is also used on the system
    set viminfo='10,\"100,:20,h,%,n~/.viminfo
endif
