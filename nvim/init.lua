-- set ',' as the leader key
-- NOTE: must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- install `lazy.nvim` plugin manager
-- https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

-- configure plugins
require('lazy').setup({
    spec = {
        import = 'plugins'
    },
    opts = {
        install = {
            colorscheme = 'solarized', -- colorscheme when starting an installation during startup
        },
    },
})

-- apply my custom options and keymaps
require 'abg'
