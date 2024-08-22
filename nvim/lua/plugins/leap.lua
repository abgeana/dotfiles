return {
    'ggandor/leap.nvim',

    config = function()
        require('leap').create_default_mappings()
        vim.cmd("hi LeapLabel guifg=Black guibg=#87ff00")
    end,
}
