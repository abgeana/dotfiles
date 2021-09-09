local cmd = vim.cmd
local fn = vim.fn

-- automatically install vim-plug if it is missing
local plug_install_path = fn.stdpath('config') .. '/autoload/plug.vim'
local plug_install_url = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
if fn.empty(fn.glob(plug_install_path)) then
    fn.system({'curl', '-fLo', plug_install_path, '--create-dirs', plug_install_url})
end

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'google/vim-maktaba'           -- dependency for vim-codefmt
Plug 'inkarkat/vim-ingo-library'    -- dependency for vim-mark
Plug 'godlygeek/tabular'            -- dependency for vim-markdown
Plug 'prabirshrestha/async.vim'     -- dependency for vim-lsp

Plug('Shougo/denite.nvim', {
    ['do'] = function()
        cmd('UpdateRemotePlugins')
    end
})

-- fzf integration
Plug '/usr/share/nvim/site/plugin/fzf.vim'      -- instead of cloning the fzf repo for a file
Plug 'junegunn/fzf.vim'

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
Plug('Shougo/defx.nvim', {
    ['do'] = function()
        cmd('UpdateRemotePlugins')
    end
})

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
