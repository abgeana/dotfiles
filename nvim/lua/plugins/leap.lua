return {
    'ggandor/leap.nvim',

    config = function()
        vim.keymap.set({'n', 'x', 'o'}, 's', '<Plug>(leap)')
        vim.keymap.set('n',             'S', '<Plug>(leap-from-window)')
        vim.cmd('hi LeapLabel guifg=Black guibg=#87ff00')
    end,
}
