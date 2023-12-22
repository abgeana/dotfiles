return {
    -- use different syntax highlighting for arbitrary ranges
    'inkarkat/vim-SyntaxRange',

    config = function()
        vim.cmd [[ autocmd Syntax * call SyntaxRange#Include('@begin=lua@', '@end=lua@', 'lua', 'NonText') ]]
    end,
}
