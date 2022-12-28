-- vim: foldmethod=marker

-- automatically install packer.nvim if it is missing
local packer_install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local packer_git_url = 'https://github.com/wbthomason/packer.nvim'
if vim.fn.empty(vim.fn.glob(packer_install_path)) then
    vim.fn.system({'git', 'clone', '--depth', '1', packer_git_url, packer_install_path})
end

local ok, packer = pcall(require, 'packer')
if not ok then
    return
end

packer.startup(function(use)
    -- packer is first to manage itself
    use 'wbthomason/packer.nvim'

    use 'zhimsel/vim-stay'                         -- persistent editing state; originally kopischke/vim-stay
    use 'wsdjeg/vim-fetch'                         -- line and column in file name; originally kopischke/vim-fetch
    use 'abgeana/nvim-fugitive'

    use {
        'troydm/zoomwintab.vim', -- {{{
        setup = function()
            vim.g.zoomwintab_remap = 0
        end,
        config = function()
            local k = vim.api.nvim_set_keymap
            k('n', '<Leader>z',   [[<Cmd>ZoomWinTabToggle<Cr>]], {})
        end,
        -- }}}
    }

    use {
        'svrana/neosolarized.nvim', -- {{{
        config = function()
            c = require('neosolarized').setup({
                comment_italics = false,
            })
            -- to figure out how each group looks like, run
            -- :runtime syntax/hitest.vim
            c.Group.new('FoldColumn', c.colors.none, c.colors.bg, c.styles.none)

            vim.o.background = 'dark'
            vim.o.termguicolors = true
        end,
        requires = {
            'tjdevries/colorbuddy.nvim',
        }
        -- }}}
    }
    use {
        'justinmk/vim-sneak', -- {{{
        config = function()
            -- use labels for jump spots
            vim.g['sneak#label'] = 1
            -- press "s" to go to the next match
            vim.g['sneak#s_next'] = 1
            -- case sensitivity determined by ignorecase and smartcase
            vim.g['sneak#use_ic_scs'] = 1
        end,
        -- }}}
    }
    use {
        'google/vim-codefmt', -- {{{
        config = function()
            local k = vim.api.nvim_set_keymap

            k('n', '<A-f>', '<Cmd>FormatCode<Cr>', { noremap = true, silent = true })
            -- change default formatter for javascript buffers from clang-format to js-beautify
            -- https://github.com/google/vim-codefmt/blob/0bf16eb74e8243ee477ad97330e451026311fbae/instant/flags.vim#L24
            -- https://github.com/google/vim-codefmt/blob/78f646545c4e1254fc413242e5c204a2dc79665d/vroom/main.vroom#L137
            vim.cmd('autocmd FileType javascript let b:codefmt_formatter="prettier"')
        end,
        requires = {
            'google/vim-maktaba',
            'google/vim-glaive',
        },
        -- }}}
    }
    use {
        'google/vim-coverage', -- {{{
        config = function()
        -- to get the maktaba plugin, use
        --   let coverage_plugin=maktaba#plugin#Get('coverage')
        -- after which you can configure the gcov plugin via
        --   let coverage_plugin.globals._gcov_temp_search_paths = ['...']
        --   let coverage_plugin.globals._gcov_temp_file_patterns = ['...']
        end,
        requires = {
            'google/vim-maktaba',
            'google/vim-glaive',
        },
        -- }}}
    }
    use {
        'christoomey/vim-tmux-navigator', -- {{{
        config = function()
            local k = vim.api.nvim_set_keymap

            vim.g.tmux_navigator_no_mappings = 1

            k('', '<A-h>',  '<Cmd>TmuxNavigateLeft<Cr>',     { noremap = true, silent = true })
            k('', '<A-j>',  '<Cmd>TmuxNavigateDown<Cr>',     { noremap = true, silent = true })
            k('', '<A-k>',  '<Cmd>TmuxNavigateUp<Cr>',       { noremap = true, silent = true })
            k('', '<A-l>',  '<Cmd>TmuxNavigateRight<Cr>',    { noremap = true, silent = true })
            k('', '<A-\\>', '<Cmd>TmuxNavigatePrevious<Cr>', { noremap = true, silent = true })
        end,
        -- }}}
    }
    use {
        'abgeana/vim-mark', -- {{{
        config = function()
            local k = vim.api.nvim_set_keymap
            -- use a proper palette
            vim.g.mwDefaultHighlightingPalette = 'maximum'
            -- if the mark plugin is available use it together with
            -- the regular search highlighting
            k('',  '<F1>', '<Leader>m', {})
            k('n', '<F2>', '<Cmd>lua require \'util\'.do_search(false)<Cr>' .. '<Cmd>setl hlsearch<Cr>', {})
            k('v', '<F2>', '<Esc>' .. '<Cmd>lua require \'util\'.do_search(true)<Cr>' .. '<Esc>' .. '<Cmd>setl hlsearch<Cr>', {})
            k('',  '<F3>', '<Cmd>setl hlsearch!<Cr>', {})
            k('',  '<F4>', '<Cmd>MarkClear<Cr>' .. '<Cmd>setl nohlsearch<Cr>', {})
        end,
        requires = 'inkarkat/vim-ingo-library',
        -- }}}
    }
    use {
        'inkarkat/vim-DeleteTrailingWhitespace', -- {{{
        config = function()
            -- check whether the file is open in binary mode or not
            if vim.o.binary == false then
                -- i want to eradicate all trailing spaces all the time
                vim.g['DeleteTrailingWhitespace'] = 1
                -- automatically do it for me when i save a file
                vim.g['DeleteTrailingWhitespace_Action'] = 'delete'
            end
        end,
        -- }}}
    }
    use {
        'inkarkat/vim-SyntaxRange', -- {{{
        -- use different syntax highlighting for arbitrary ranges
        config = function()
            vim.cmd([[ autocmd Syntax * call SyntaxRange#Include('@begin=lua@', '@end=lua@', 'lua', 'NonText') ]])
        end,
        -- }}}
    }
    use {
        'nvim-treesitter/nvim-treesitter', -- {{{
        run = function()
            -- https://github.com/nvim-treesitter/nvim-treesitter/wiki/Installation#packernvim
            -- https://github.com/nvim-treesitter/nvim-treesitter/blob/fb36ed4c9e962d9fbfa608cd4a5d9313b1e8a8b1/lua/nvim-treesitter/install.lua#L689
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()

            -- https://github.com/nvim-treesitter/nvim-treesitter/blob/fb36ed4c9e962d9fbfa608cd4a5d9313b1e8a8b1/lua/nvim-treesitter/install.lua#L662
            local ts_install = require('nvim-treesitter.install').install({ ask_reinstall = 'force' })
            ts_install('c')
            ts_install('rust')
            ts_install('python')
            ts_install('go')
            ts_install('vim')
            ts_install('help')
        end,
        config = function()
            require'nvim-treesitter.configs'.setup {
                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
            }
        end,
        -- }}}
    }

    -- lsp {{{
    use {
        'onsails/lspkind.nvim', -- {{{
        config = function()
            require('lspkind').init()
        end,
        -- }}}
    }
    use {
        'hrsh7th/nvim-cmp', -- {{{
        requires = {
            -- https://github.com/hrsh7th/nvim-cmp/blob/a226b6a4ff72e5e809ed17734318233fb25c87f3/doc/cmp.txt#L47
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            -- https://github.com/hrsh7th/nvim-cmp/blob/a226b6a4ff72e5e809ed17734318233fb25c87f3/doc/cmp.txt#L55
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
        },
        -- }}}
    }
    use {
        'neovim/nvim-lspconfig', -- {{{
        config = function()
            local lspconfig = require('lspconfig')
            local cmp_nvim_lsp = require('cmp_nvim_lsp')
            local cmp = require('cmp')
            local lspkind = require('lspkind')


            -- disable inline buffer error messages (linting)
            -- https://github.com/neovim/nvim-lspconfig/issues/662
            vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
                vim.lsp.diagnostic.on_publish_diagnostics, {
                    underline = false,
                    virtual_text = false,
                    signs = false
                }
            )

            lspconfig.clangd.setup { -- {{{
                capabilities = cmp_nvim_lsp.default_capabilities(),
                flags = {
                    debounce_text_changes = 150,
                }
            } -- }}}

            local cwd = vim.fn.getcwd()
            cwd = cwd:gsub('/', "_")
            lspconfig.rust_analyzer.setup { -- {{{
                capabilities = cmp_nvim_lsp.default_capabilities({
                    -- disable snippet support such that functions names are completed
                    -- without the additional arguments afterwards
                    snippetSupport = false
                }),
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
                    CARGO_TARGET_DIR = "/tmp/rust-analyzer" .. cwd
                }
            } -- }}}

            lspconfig.pyright.setup { -- {{{
                capabilities = cmp_nvim_lsp.default_capabilities(),
                vim.lsp.diagnostic.on_publish_diagnostics, {
                    underline = false,
                    virtual_text = false,
                    signs = false
                }
            } -- }}}

            cmp.setup({ -- {{{
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
            }) -- }}}

        end,
        after = {
            'lspkind.nvim',
            'nvim-cmp'
        }
        -- }}}
    }
    -- }}}

    -- telescope {{{
    use {
        'nvim-telescope/telescope-fzf-native.nvim', -- {{{
        run = 'make',
        -- }}}
    }
    use {
        'nvim-telescope/telescope.nvim', -- {{{
        config = function()
            local k = vim.api.nvim_set_keymap
            k('n', '<Leader>ff',   [[<Cmd>Telescope find_files<Cr>]], {})
            k('n', '<Leader>fg',   [[<Cmd>Telescope live_grep<Cr>]], {})
            k('n', '<Leader>fw',   [[<Cmd>Telescope grep_string<Cr>]], {})
            k('n', '<Leader>fb',   [[<Cmd>Telescope buffers<Cr>]], {})
            k('n', '<Leader>fh',   [[<Cmd>Telescope help_tags<Cr>]], {})
            k('n', '<Leader>gd',   [[<Cmd>Telescope lsp_definitions<Cr>]], {})
            k('n', '<Leader>gr',   [[<Cmd>Telescope lsp_references<Cr>]], {})
            k('n', '<Leader>gs',   [[<Cmd>Telescope lsp_document_symbols<Cr>]], {})
        end,
        requires = 'nvim-lua/plenary.nvim',
        after = {
            'telescope-fzf-native.nvim',
            'nvim-lspconfig',
        }
        -- }}}
    }
    -- }}}

    -- language support {{{
    use {
        'plasticboy/vim-markdown', -- {{{
        config = function()
            vim.g['vim_markdown_folding_disabled'] = 1
            -- https://github.com/plasticboy/vim-markdown#concealing
            vim.cmd('autocmd FileType markdown setlocal conceallevel=2')
        end,
        requires = 'godlygeek/tabular',
        -- }}}
    }
    -- use 'PProvost/vim-ps1'                 -- powershell
    -- use 'dart-lang/dart-vim-plugin'
    -- use 'mustache/vim-mustache-handlebars' -- html mustache/handlebars
    -- use 'matze/vim-meson'
    -- use 'HerringtonDarkholme/yats.vim'     -- typescript
    -- use 'udalov/kotlin-vim'
    -- use 'keith/swift.vim'
    -- use 'LnL7/vim-nix'
    -- use 'nfnty/vim-nftables'
    -- }}}
end)
