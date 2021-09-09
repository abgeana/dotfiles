local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- enable completion via the lsp
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- mapping options
    local opts = { noremap=true, silent=true }

    -- see `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'gD',           '<Cmd>' .. 'lua vim.lsp.buf.declaration()'                                  .. '<CR>', opts)
    buf_set_keymap('n', 'gd',           '<Cmd>' .. 'lua vim.lsp.buf.definition()'                                   .. '<CR>', opts)
    buf_set_keymap('n', 'K',            '<Cmd>' .. 'lua vim.lsp.buf.hover()'                                        .. '<CR>', opts)
    buf_set_keymap('n', 'gi',           '<Cmd>' .. 'lua vim.lsp.buf.implementation()'                               .. '<CR>', opts)
  --buf_set_keymap('n', '<C-k>',        '<Cmd>' .. 'lua vim.lsp.buf.signature_help()'                               .. '<CR>', opts)
  --buf_set_keymap('n', '<space>wa',    '<Cmd>' .. 'lua vim.lsp.buf.add_workspace_folder()'                         .. '<CR>', opts)
  --buf_set_keymap('n', '<space>wr',    '<Cmd>' .. 'lua vim.lsp.buf.remove_workspace_folder()'                      .. '<CR>', opts)
  --buf_set_keymap('n', '<space>wl',    '<Cmd>' .. 'lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))'   .. '<CR>', opts)
  --buf_set_keymap('n', '<space>D',     '<Cmd>' .. 'lua vim.lsp.buf.type_definition()'                              .. '<CR>', opts)
  --buf_set_keymap('n', '<space>rn',    '<Cmd>' .. 'lua vim.lsp.buf.rename()'                                       .. '<CR>', opts)
  --buf_set_keymap('n', '<space>ca',    '<Cmd>' .. 'lua vim.lsp.buf.code_action()'                                  .. '<CR>', opts)
    buf_set_keymap('n', 'gr',           '<Cmd>' .. 'lua vim.lsp.buf.references()'                                   .. '<CR>', opts)
  --buf_set_keymap('n', '<space>e',     '<Cmd>' .. 'lua vim.lsp.diagnostic.show_line_diagnostics()'                 .. '<CR>', opts)
  --buf_set_keymap('n', '[d',           '<Cmd>' .. 'lua vim.lsp.diagnostic.goto_prev()'                             .. '<CR>', opts)
  --buf_set_keymap('n', ']d',           '<Cmd>' .. 'lua vim.lsp.diagnostic.goto_next()'                             .. '<CR>', opts)
  --buf_set_keymap('n', '<space>q',     '<Cmd>' .. 'lua vim.lsp.diagnostic.set_loclist()'                           .. '<CR>', opts)
  --buf_set_keymap("n", '<space>f',     '<Cmd>' .. 'lua vim.lsp.buf.formatting()'                                   .. '<CR>', opts)
end

setup_lsp_servers = function()

    -- list of servers to enable by default
    local servers = {
        "ccls",
        "rust_analyzer"
    }

    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
            on_attach = on_attach,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end

    -- disable inline buffer error messages (linting)
    -- https://github.com/neovim/nvim-lspconfig/issues/662
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = false,
            virtual_text = false,
            signs = false,
        }
    )

end
