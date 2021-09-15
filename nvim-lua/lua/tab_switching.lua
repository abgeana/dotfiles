local util = require 'util'

local k = vim.api.nvim_set_keymap
local t = util.termcode

local last_killed_buffer = -1

-- function to close the window in the tab and remember the buffer ID
_G.buffer_in_tab_kill = function()
    last_killed_buffer = vim.fn.bufnr('%')
    vim.api.nvim_command('wincmd c')
end
-- use tk as "buffer in Tab Kill" to close the window the tab
k('n', 'tk', '<Cmd>call v:lua.buffer_in_tab_kill()<Cr>', { noremap = true, silent = true })

-- function to restore a previously killed buffer in the current window
_G.buffer_in_tab_resurrect = function()
    if last_killed_buffer == -1 then
        return
    end
    vim.api.nvim_command('b' .. last_killed_buffer)
end
-- use tr as "buffer in Tab Resurrect" to re-open the last killed buffer
k('n', 'tr', '<Cmd>call v:lua.buffer_in_tab_resurrect()<Cr>', { noremap = true, silent = true })

-- use ts as "buffer to new Tab Split" plus closing the original window
k('n', 'ts', '<C-w>T', { noremap = true, silent = true })
