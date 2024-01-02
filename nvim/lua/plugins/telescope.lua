return {
    {
        -- https://github.com/nvim-telescope/telescope-fzf-native.nvim?tab=readme-ov-file#lazynvim
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
    {
        'nvim-telescope/telescope.nvim',
        config = function()
            local telescope = require 'telescope'
            local telescope_actions = require "telescope.actions"
            local fb_actions = require('telescope').extensions.file_browser.actions

            telescope.setup {
                defaults = {
                    mappings = {
                        n = {
                            ['s'] = telescope.extensions.hop.hop,
                            ["<C-s>"] = telescope_actions.select_horizontal,
                            ["<C-v>"] = telescope_actions.select_vertical, -- default
                        },
                        i = {
                            ["<C-s>"] = telescope_actions.select_horizontal,
                            ["<C-v>"] = telescope_actions.select_vertical, -- default
                        },
                    },
                },
                extensions = {
                    file_browser = {
                        mappings = {
                            ['n'] = {
                                ['h'] = fb_actions.goto_parent_dir,
                                ['l'] = 'select_default',
                                ['cd'] = fb_actions.change_cwd,
                            },
                        },
                    },
                },
            }

            telescope.load_extension 'file_browser'
            telescope.load_extension 'hop'

            vim.keymap.set('n', '<Leader>ff', [[<Cmd>Telescope find_files<Cr>]])
            vim.keymap.set('n', '<Leader>fg', [[<Cmd>Telescope live_grep<Cr>]])
            vim.keymap.set('n', '<Leader>fw', [[<Cmd>Telescope grep_string<Cr>]])
            vim.keymap.set('n', '<Leader>fb', [[<Cmd>Telescope file_browser<Cr>]])
            vim.keymap.set('n', '<Leader>fh', [[<Cmd>Telescope help_tags<Cr>]])
            vim.keymap.set('n', '<Leader>gd', [[<Cmd>Telescope lsp_definitions<Cr>]])
            vim.keymap.set('n', '<Leader>gr', [[<Cmd>Telescope lsp_references<Cr>]])
            vim.keymap.set('n', '<Leader>ds', [[<Cmd>Telescope lsp_document_symbols<Cr>]]) -- ds because the command is document symbols
            vim.keymap.set('n', '<Leader>bs', [[<Cmd>Telescope lsp_document_symbols<Cr>]]) -- bs because i sometimes think buffer symbols
            -- lsp_dynamic_workspace_symbols differs from lsp_workspace_symbols in the sense
            -- that it generates the list of symbols dynamically while you are typing a name
            -- see also https://github.com/nvim-telescope/telescope.nvim/issues/964
            vim.keymap.set('n', '<Leader>ws', [[<Cmd>Telescope lsp_dynamic_workspace_symbols<Cr>]])
        end,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'nvim-telescope/telescope-hop.nvim',
            'nvim-telescope/telescope-file-browser.nvim',
            'neovim/nvim-lspconfig',
        },
    },
}
