" vim: foldmethod=marker

" alegen/vim-mark {{{
if empty(glob('~/.config/nvim/plugged/vim-mark/plugin/mark.vim')) == 0
    " use a proper palette
    let g:mwDefaultHighlightingPalette = 'maximum'
    " if the mark plugin is available use it together with
    " the regular search highlighting
    map <F1> <Leader>m
    nnoremap <F2> :call DoSearch(0)<CR>:setl hlsearch<CR>
    vnoremap <F2> :call DoSearch(1)<CR><Esc>:setl hlsearch<CR>
    map <F3> :setl hlsearch!<CR>
    map <F4> :MarkClear<CR>:setl nohlsearch<CR>
else
    " if the plugin is not available, use only search highlighting
    map <F1> :setl hlsearch<CR>:let @/ = expand("<cword>")<CR>
    map <F2> :setl hlsearch!<CR>
endif
" }}}

" Shougo/defx.nvim {{{
if empty(glob('~/.config/nvim/plugged/defx.nvim/plugin/defx.vim')) == 0
    map <A-x> :Defx<CR>

    call defx#custom#option('_', {
    \   'split':        'vertical',
    \   'winwidth':     50,
    \   'direction':    'topleft',
    \   'listed':       1,
    \   'resume':       1,
    \   'toggle':       1
    \ })

    autocmd FileType defx call s:defx_my_settings()
    function! s:defx_my_settings() abort " {{{
        " Define mappings
        nnoremap <silent><buffer><expr> <CR>
        \ defx#is_directory() ?
        \ defx#do_action('open_tree', 'toggle') :
        \ defx#do_action('multi', ['drop', 'quit'])

        nnoremap <silent><buffer><expr> h
        \ defx#do_action('cd', ['..'])
        nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
        nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
        nnoremap <silent><buffer><expr> l
        \ defx#do_action('open')

        nnoremap <silent><buffer><expr> s
        \ defx#do_action('multi', [['drop', 'split'], 'quit'])
        nnoremap <silent><buffer><expr> v
        \ defx#do_action('multi', [['drop', 'vsplit'], 'quit'])

        nnoremap <silent><buffer><expr> o
        \ defx#do_action('open_tree', 'toggle')
        nnoremap <silent><buffer><expr> !
        \ defx#do_action('execute_command')
        nnoremap <silent><buffer><expr> yy
        \ defx#do_action('yank_path')
        nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
        nnoremap <silent><buffer><expr> ~
        \ defx#do_action('cd')
        nnoremap <silent><buffer><expr> <C-l>
        \ defx#do_action('redraw')
        nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
    endfunction
    " }}}
endif
" }}}

" justinmk/vim-sneak {{{
if empty(glob('~/.config/nvim/plugged/vim-sneak/plugin/sneak.vim')) == 0
    " use labels for jump spots
    let g:sneak#label = 1
    " press "s" to go to the next match
    let g:sneak#s_next = 1
    " case sensitivity determined by ignorecase and smartcase
    let g:sneak#use_ic_scs = 1
endif
" }}}

" plasticboy/vim-markdown {{{
if empty(glob('~/.config/nvim/plugged/vim-markdown/ftplugin/markdown.vim')) == 0
    let g:vim_markdown_folding_disabled = 1
    " https://github.com/plasticboy/vim-markdown#concealing
    autocmd FileType markdown setlocal conceallevel=2
endif
" }}}

" inkarkat/vim-DeleteTrailingWhitespace {{{
if empty(glob('~/.config/nvim/plugged/vim-DeleteTrailingWhitespace/plugin/DeleteTrailingWhitespace.vim')) == 0 && &binary == "nobinary"
    " i want to eradicate all trailing spaces all the time
    let g:DeleteTrailingWhitespace = 1
    " automatically do it for me when i save a file
    let g:DeleteTrailingWhitespace_Action = 'delete'
endif
" }}}

" christoomey/vim-tmux-navigator {{{
if empty(glob('~/.config/nvim/plugged/vim-tmux-navigator/plugin/tmux_navigator.vim')) == 0
    let g:tmux_navigator_no_mappings = 1

    nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
    nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>
endif
" }}}

" google/vim-codefmt {{{
if empty(glob('~/.config/nvim/plugged/vim-codefmt/autoload/codefmt.vim')) == 0
    nnoremap <silent> <A-f> :FormatCode<cr>
    " change default formatter for javascript buffers from clang-format to js-beautify
    " https://github.com/google/vim-codefmt/blob/0bf16eb74e8243ee477ad97330e451026311fbae/instant/flags.vim#L24
    " https://github.com/google/vim-codefmt/blob/78f646545c4e1254fc413242e5c204a2dc79665d/vroom/main.vroom#L137
    autocmd FileType javascript let b:codefmt_formatter="prettier"
endif
" }}}

" inkarkat/vim-SyntaxRange {{{
if empty(glob('~/.config/nvim/plugged/vim-SyntaxRange/plugin/SyntaxRange.vim')) == 0
    autocmd Syntax * call SyntaxRange#Include('@begin=lua@', '@end=lua@', 'lua', 'NonText')
endif
" }}}
