return {
    'nvim-treesitter/nvim-treesitter',

    config = function()
        require('nvim-treesitter.configs').setup {
            ensure_installed = {
                'c',
                'cpp',
                'rust',
                'python',
                'lua',
                'go',
                'vim',
                'java',
            },
            auto_install = true, -- requires tree-sitter cli installed

            highlight = {
                enable = true,
                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false,
            },
        }

        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
}
