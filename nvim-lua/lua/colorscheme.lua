vim.o.background = 'dark'

if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-colors-solarized/colors/solarized.vim')) == 0 then
    vim.cmd [[
        autocmd colorscheme solarized highlight colorcolumn ctermbg=1
        colorscheme solarized
        hi StatusLine cterm=reverse ctermfg=0 ctermbg=2 gui=bold,reverse
        hi StatusLineNC cterm=reverse ctermfg=0 ctermbg=3 gui=bold,reverse
        hi VertSplit ctermfg=11 ctermbg=0 gui=reverse
        set fillchars+=vert:\ " white space at the end
    ]]
else
    vim.cmd [[
        autocmd colorscheme darkblue highlight normal ctermbg=8
        colorscheme darkblue
    ]]
end
