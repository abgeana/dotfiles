return {
    {
        'nvim-tree/nvim-web-devicons', -- nerd fonts support

        config = function()
            require('nvim-web-devicons').setup {}
        end,
    },
    {
        'onsails/lspkind.nvim', -- vscode-like pictograms to neovim built-in lsp

        config = function()
            require('lspkind').init()
        end,
    },
}
