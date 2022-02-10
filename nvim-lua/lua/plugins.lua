-- automatically install vim-plug if it is missing
local plug_install_path = vim.fn.stdpath('config') .. '/autoload/plug.vim'
local plug_install_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if vim.fn.empty(vim.fn.glob(plug_install_path)) then
    vim.fn.system({'curl', '-fLo', plug_install_path, '--create-dirs', plug_install_url})
end

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'google/vim-maktaba'           -- dependency for vim-codefmt
Plug 'inkarkat/vim-ingo-library'    -- dependency for vim-mark
Plug 'godlygeek/tabular'            -- dependency for vim-markdown
Plug 'prabirshrestha/async.vim'     -- dependency for vim-lsp
Plug 'nvim-lua/plenary.nvim'        -- dependency for telescope.nvim

Plug('Shougo/denite.nvim', {
    ['do'] = function()
        vim.cmd('UpdateRemotePlugins')
    end
})

Plug 'altercation/vim-colors-solarized'
Plug 'justinmk/vim-sneak'
Plug 'zhimsel/vim-stay'                         -- persistent editing state; originally kopischke/vim-stay
Plug 'wsdjeg/vim-fetch'                         -- line and column in file name; originally kopischke/vim-fetch
Plug 'google/vim-codefmt'
Plug 'google/vim-coverage'
Plug 'christoomey/vim-tmux-navigator'
Plug 'alegen/vim-mark'                          -- background coloring of arbitrary strings
Plug 'inkarkat/vim-DeleteTrailingWhitespace'
Plug 'inkarkat/vim-SyntaxRange'                 -- use different syntax highlighting for arbitrary ranges
Plug 'majutsushi/tagbar'
Plug 'neovim/nvim-lspconfig'                    -- quickstart configurations for the nvim lsp client
Plug('nvim-treesitter/nvim-treesitter', {
    ['do'] = function()
        vim.cmd('TSUpdate')
    end
})
Plug 'nvim-telescope/telescope.nvim'

-- language syntax plugins
Plug 'plasticboy/vim-markdown'
Plug 'PProvost/vim-ps1'                 -- powershell
-- Plug 'dart-lang/dart-vim-plugin'
-- Plug 'mustache/vim-mustache-handlebars' -- html mustache/handlebars
-- Plug 'matze/vim-meson'
-- Plug 'HerringtonDarkholme/yats.vim'     -- typescript
-- Plug 'udalov/kotlin-vim'
-- Plug 'keith/swift.vim'
-- Plug 'alegen/vim-smali'
-- Plug 'LnL7/vim-nix'
-- Plug 'nfnty/vim-nftables'

vim.call('plug#end')

-- vim-plug automatically calls 'filetype indent on'
-- https://github.com/junegunn/vim-plug#usage
vim.cmd('filetype indent off') -- disable loading indent files for specific file types
