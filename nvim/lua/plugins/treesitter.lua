return {
    'nvim-treesitter/nvim-treesitter',

    config = function()
        languages = {
            'c',
            'cpp',
            'rust',
            'python',
            'lua',
            'go',
            'vim',
            'java',
            'toml'
        }

        require('nvim-treesitter').install(languages)

        for _, language in ipairs(languages) do
            -- Enable highlighting using treesitter.
            -- https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#highlighting
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { language },
                callback = function() vim.treesitter.start() end,
            })
        end

        vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
}
