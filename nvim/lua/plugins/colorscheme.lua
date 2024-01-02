return {
    'svrana/neosolarized.nvim',
    lazy = false,
    priority = 1000,

    config = function()
        require('neosolarized').setup {
            comment_italics = false,
        }

        vim.o.background = 'dark'
        vim.o.termguicolors = true
    end,

    dependencies = {
        'tjdevries/colorbuddy.nvim',
    },
}
