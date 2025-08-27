return {
    'neovim/nvim-lspconfig',

    config = function()
        local lspconfig = require 'lspconfig'

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
            callback = function(ev)
                vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {autotrigger = true})
            end,
        })

        vim.lsp.enable('clangd')
        vim.lsp.enable('gopls')
        vim.lsp.enable('pyright')
        vim.lsp.enable('ada_ls')

        local cwd = vim.fn.getcwd()
        cwd = cwd:gsub('/', '_')
        vim.lsp.config('rust_analyzer', {
            cmd_env = {
                CARGO_TARGET_DIR = '/tmp/rust-analyzer' .. cwd,
            },
        })
        vim.lsp.enable('rust_analyzer')
    end
}
