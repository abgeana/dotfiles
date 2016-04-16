" escape sequences for urxvt/mintty
" these can be obtained with cat
" also ontopic is http://vim.wikia.com/wiki/Mapping_fast_keycodes_in_terminal_Vim
" do not just type, instead enter Insert mode and type Ctrl-v followed by key stroke
if $USER_TERM == '' || $USER_TERM == 'rxvt'
    set <F1>=[11~
    set <F2>=[12~
    set <F3>=[13~
    set <F4>=[14~
    set <F5>=[15~
    set <F6>=[17~
    set <F7>=[18~
    set <F8>=[19~
    set <F9>=[20~
    set <F10>=[21~
    set <F11>=[23~
    set <F12>=[24~
elseif $USER_TERM == 'mintty'
    set <F1>=OP
    set <F2>=OQ
    set <F3>=OR
    set <F4>=OS
    set <F5>=[15~
    set <F6>=[17~
    set <F7>=[18~
    set <F8>=[19~
    set <F9>=[20~
    set <F10>=[21~
    set <F11>=[23~
    set <F12>=[24~
else
    echo 'There was an error setting the $USER_TERM'
endif
