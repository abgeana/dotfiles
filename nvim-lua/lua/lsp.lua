local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- enable completion via the lsp
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
end

function lsp_setup()
    -- disable inline buffer error messages (linting)
    -- https://github.com/neovim/nvim-lspconfig/issues/662
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = false,
            virtual_text = false,
            signs = false
        }
    )

    nvim_lsp.ccls.setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }

    nvim_lsp.rust_analyzer.setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            -- https://rust-analyzer.github.io/manual.html
            ["rust-analyzer"] = {
                checkOnSave = {
                    -- change the target dir for analysis on file save such that it
                    -- does not lock the cargo project and everything cargo related
                    extraArgs={"--target-dir", "/tmp/rust-analyzer-check"}
                }
            }
        }
    }
end
