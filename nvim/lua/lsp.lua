local nvim_lsp = require('lspconfig')
local cmp = require('cmp')
local ok, lspkind = pcall(require, "lspkind")
if not ok then
  return
end

lspkind.init()

local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
end

cmp.setup({
    -- the arguments below are documented by the project
    -- https://github.com/hrsh7th/nvim-cmp/blob/a226b6a4ff72e5e809ed17734318233fb25c87f3/doc/cmp.txt#L360-L362
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)            -- For vsnip users.
            -- require('luasnip').lsp_expand(args.body)     -- For luasnip users.
            -- require'snippy'.expand_snippet(args.body)    -- For snippy users.
            -- vim.fn["UltiSnips#Anon"](args.body)          -- For ultisnips users.
        end,
    },

    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-j>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-k>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
        ["<C-e>"] = cmp.mapping.abort(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),

    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' },           -- For vsnip users.
        -- { name = 'luasnip' },      -- For luasnip users.
        -- { name = 'snippy' },       -- For snippy users.
        -- { name = 'ultisnips' },    -- For ultisnips users.
    }, {
        { name = 'buffer' },
    }),

    formatting = {
        format = lspkind.cmp_format {
            with_text = true,
            menu = {
                buffer = "[buf]",
                nvim_lsp = "[LSP]",
                nvim_lua = "[api]",
                path = "[path]",
                luasnip = "[snip]",
                gh_issues = "[issues]",
                tn = "[TabNine]",
            },
        }
    },

    experimental = {
        native_menu = false
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }

    nvim_lsp.rust_analyzer.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
        settings = {
            -- https://rust-analyzer.github.io/manual.html
            ["rust-analyzer"] = {
                checkOnSave = {
                    -- https://doc.rust-lang.org/cargo/commands/cargo-check.html#output-options
                    -- change directory for all generated artifacts and intermediate files
                    -- this is an alternative to the CARGO_TARGET_DIR environment variable
                    --extraArgs={"--target-dir", "/tmp/rust-analyzer-check"}
                }
            }
        },
        cmd_env = {
            CARGO_TARGET_DIR = "/tmp/rust-analyzer-check"
        }
    }
end
