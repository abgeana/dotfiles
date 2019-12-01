" mark
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

" nerdtree
if empty(glob('~/.config/nvim/plugged/nerdtree/plugin/NERD_tree.vim')) == 0
    " do not display header
    let g:NERDTreeMinimalUI=1
    " show line numbers in the file viewer
    let g:NERDTreeShowLineNumbers=1
    " make splits behave same as with ctrl-w
    let g:NERDTreeMapOpenSplit='s'
    let g:NERDTreeMapOpenVSplit='v'

    map <A-x> :NERDTreeToggle<CR>
endif

" sneak
if empty(glob('~/.config/nvim/plugged/vim-sneak/plugin/sneak.vim')) == 0
    " use labels for jump spots
    let g:sneak#label = 1
    " press "s" to go to the next match
    let g:sneak#s_next = 1
    " case sensitivity determined by ignorecase and smartcase
    let g:sneak#use_ic_scs = 1
endif

" taglist
if empty(glob('~/.config/nvim/plugged/taglist.vim/plugin/taglist.vim')) == 0
    let g:Tlist_Use_Right_Window = 1
    let g:Tlist_WinWidth = 60
    let g:Tlist_Sort_Type = "name"
endif

" vim-markdown
if empty(glob('~/.config/nvim/plugged/vim-markdown/ftplugin/markdown.vim')) == 0
    let g:vim_markdown_folding_disabled = 1
endif

" DeleteTrailingWhitespace
if empty(glob('~/.config/nvim/plugged/vim-DeleteTrailingWhitespace/plugin/DeleteTrailingWhitespace.vim')) == 0 && &binary == "nobinary"
    " i want to eradicate all trailing spaces all the time
    let g:DeleteTrailingWhitespace = 1
    " automatically do it for me when i save a file
    let g:DeleteTrailingWhitespace_Action = 'delete'
endif

" vim-lsp
if empty(glob('~/.config/nvim/plugged/vim-lsp/plugin/lsp.vim')) == 0 && executable('ccls')
    " disable diagnostics support
    let g:lsp_diagnostics_enabled = 0
    " disable signs
    let g:lsp_signs_enabled = 0
    " disable echo under cursor when in normal mode
    let g:lsp_diagnostics_echo_cursor = 0

    " https://github.com/MaskRay/ccls/wiki/Project-Setup
    "let l:project_file = "compile_commands.json"
    let g:lsp_project_file = ".ccls"

    " https://github.com/MaskRay/ccls/wiki/vim-lsp
    " https://github.com/prabirshrestha/vim-lsp/wiki/Servers-ccls
    au User lsp_setup call lsp#register_server({
        \ 'name': 'ccls',
        \ 'cmd': {server_info->['ccls']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), g:lsp_project_file))},
        \ 'initialization_options': {'cache': {'directory': '/tmp/ccls/cache' }},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
        \ })
endif

" vim-tmux-navigator
if empty(glob('~/.config/nvim/plugged/vim-tmux-navigator/plugin/tmux_navigator.vim')) == 0
    let g:tmux_navigator_no_mappings = 1

    nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
    nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
    nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
    nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
    nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>
endif

" codefmt
if empty(glob('~/.config/nvim/plugged/vim-codefmt/autoload/codefmt.vim')) == 0
    nnoremap <silent> <A-f> :FormatCode<cr>
endif

" vim-SyntaxRange
if empty(glob('~/.config/nvim/plugged/vim-SyntaxRange/plugin/SyntaxRange.vim')) == 0
    autocmd Syntax * call SyntaxRange#Include('@begin=lua@', '@end=lua@', 'lua', 'NonText')
endif
