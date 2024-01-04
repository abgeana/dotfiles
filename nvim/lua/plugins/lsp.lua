return {
    {
        'hrsh7th/nvim-cmp',

        config = function()
            local cmp = require 'cmp'
            local lspkind = require 'lspkind'

            local buffer_entry_filter = function(entry, _ctx)
                -- this function filters entries if they are of type text
                -- and either they are longer than 15 characters (probably some hash digest)
                -- or they start with a digit (probably some code constant)
                local cmp_types = require 'cmp.types'

                if cmp_types.lsp.CompletionItemKind[entry:get_kind()] == 'Text' then
                    local entry_1st_char = entry:get_word():sub(1, 1)
                    if entry:get_word():len() > 15 then
                        return false
                    elseif
                        string.byte '0' <= string.byte(entry_1st_char)
                        and string.byte(entry_1st_char) <= string.byte '9'
                    then
                        return false
                    end
                end

                return true
            end

            cmp.setup {
                -- the arguments below are documented by the project
                -- https://github.com/hrsh7th/nvim-cmp/blob/a226b6a4ff72e5e809ed17734318233fb25c87f3/doc/cmp.txt#L360-L362
                snippet = {
                    expand = function(args)
                        vim.fn['vsnip#anonymous'](args.body)
                    end,
                },

                mapping = cmp.mapping.preset.insert {
                    ['<C-j>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                    ['<C-k>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                    -- ['<Esc>'] = cmp.mapping.abort(), -- not a good idea, because i expect to be in normal mode after pressing escape
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<CR>'] = cmp.mapping.confirm { select = false },
                },

                sources = cmp.config.sources(
                    -- first group of sources
                    {
                        { name = 'nvim_lsp' },
                        { name = 'vsnip' },
                    },
                    -- second group of sources
                    {
                        {
                            name = 'buffer',
                            entry_filter = buffer_entry_filter,
                        },
                    }
                ),

                formatting = {
                    format = lspkind.cmp_format {
                        with_text = true,
                        menu = {
                            buffer = '[buf]',
                            nvim_lsp = '[LSP]',
                            nvim_lua = '[api]',
                            path = '[path]',
                            luasnip = '[snip]',
                            gh_issues = '[issues]',
                            tn = '[TabNine]',
                        },
                    },
                },

                experimental = {
                    native_menu = false,
                },
            }
        end,

        dependencies = {
            'onsails/lspkind.nvim',
            -- https://github.com/hrsh7th/nvim-cmp/blob/a226b6a4ff72e5e809ed17734318233fb25c87f3/doc/cmp.txt#L47
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            -- https://github.com/hrsh7th/nvim-cmp/blob/a226b6a4ff72e5e809ed17734318233fb25c87f3/doc/cmp.txt#L55
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
        },
    },
    {
        'neovim/nvim-lspconfig',

        config = function()
            local lspconfig = require 'lspconfig'
            local cmp_nvim_lsp = require 'cmp_nvim_lsp'

            local cmp_capabilities = cmp_nvim_lsp.default_capabilities {
                -- disable snippet support such that functions names are completed
                -- without the additional arguments afterwards
                snippetSupport = false,
            }

            -- disable inline buffer error messages (linting)
            -- https://github.com/neovim/nvim-lspconfig/issues/662
            vim.lsp.handlers['textDocument/publishDiagnostics'] =
                vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
                    underline = false,
                    virtual_text = false,
                    signs = false,
                })

            lspconfig.clangd.setup {
                capabilities = cmp_capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            }

            lspconfig.gopls.setup {
                capabilities = cmp_capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            }

            lspconfig.pyright.setup {
                capabilities = cmp_capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
            }

            local cwd = vim.fn.getcwd()
            cwd = cwd:gsub('/', '_')
            lspconfig.rust_analyzer.setup {
                capabilities = cmp_capabilities,
                flags = {
                    debounce_text_changes = 150,
                },
                settings = {
                    -- https://rust-analyzer.github.io/manual.html
                    ['rust-analyzer'] = {
                        checkOnSave = {
                            -- https://doc.rust-lang.org/cargo/commands/cargo-check.html#output-options
                            -- change directory for all generated artifacts and intermediate files
                            -- this is an alternative to the CARGO_TARGET_DIR environment variable
                            --extraArgs={"--target-dir", "/tmp/rust-analyzer-check"}
                        },
                    },
                },
                cmd_env = {
                    CARGO_TARGET_DIR = '/tmp/rust-analyzer' .. cwd,
                },
            }

            -- limit the number of items in the popup menu
            vim.cmd 'set pumheight=10'
        end,

        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
        },
    },
}
