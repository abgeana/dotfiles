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
            local telescope_sorters = require("telescope.sorters")
            local telescope_actions = require "telescope.actions"
            local telescope_lga_actions = require("telescope-live-grep-args.actions")
            local telescope_lga_shortcuts = require("telescope-live-grep-args.shortcuts")
            local telescope_fb_actions = require('telescope').extensions.file_browser.actions

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
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = false, -- override the generic sorter
                        override_file_sorter = false,    -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                                         -- the default case_mode is "smart_case"
                    },
                    file_browser = {
                        mappings = {
                            ['n'] = {
                                ['h'] = telescope_fb_actions.goto_parent_dir,
                                ['l'] = 'select_default',
                                ['cd'] = telescope_fb_actions.change_cwd,
                            },
                        },
                    },
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            ['i'] = {
                                ["<C-k>"] = telescope_lga_actions.quote_prompt(),
                                ["<C-i>"] = telescope_lga_actions.quote_prompt({ postfix = " --iglob " }),
                                -- freeze the current list and start a fuzzy search in the frozen list
                                ["<C-space>"] = telescope_actions.to_fuzzy_refine,
                            },
                        },
                        -- The basic vimgrep_arguments can be found here
                        -- https://github.com/nvim-telescope/telescope.nvim/blob/ad7d9580338354ccc136e5b8f0aa4f880434dcdc/lua/telescope/config.lua#L707-L708
                        vimgrep_arguments = {
                            "rg",
                            "--color=never",
                            "--no-heading",
                            "--with-filename",
                            "--line-number",
                            "--column",
                            "--smart-case",
                            "--sort", "path", -- This ensures consistent ordering
                        },
                    },
                },
            }

            telescope.load_extension 'fzf'
            telescope.load_extension 'hop'
            telescope.load_extension 'file_browser'
            telescope.load_extension 'live_grep_args'

            vim.keymap.set('n', '<Leader>ff', [[<Cmd>Telescope find_files<Cr>]])
            --vim.keymap.set('n', '<Leader>fg', [[<Cmd>Telescope live_grep<Cr>]])
            vim.keymap.set('n', '<Leader>fg', [[<Cmd>Telescope live_grep_args<Cr>]])
            --vim.keymap.set('n', '<Leader>fw', [[<Cmd>Telescope grep_string<Cr>]])
            vim.keymap.set('n', '<Leader>fw', telescope_lga_shortcuts.grep_word_under_cursor)
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
            'nvim-telescope/telescope-live-grep-args.nvim',
            'neovim/nvim-lspconfig',
        },
    },
}
