vim.o.background = 'dark'

if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-colors-solarized/colors/solarized.vim')) == 0 then
    vim.cmd [[
        autocmd colorscheme solarized highlight colorcolumn ctermbg=1
        colorscheme solarized
    ]]
else
    vim.cmd [[
        autocmd colorscheme darkblue highlight normal ctermbg=8
        colorscheme darkblue
    ]]
end
