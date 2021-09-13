-- vim: foldmethod=marker

local k = vim.api.nvim_set_keymap

--- alegen/vim-mark {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-mark/plugin/mark.vim')) == 0 then
    -- use a proper palette
    vim.g.mwDefaultHighlightingPalette = 'maximum'
    -- if the mark plugin is available use it together with
    -- the regular search highlighting
    k('', '<F1>', '<Leader>m', {})
    k('n', '<F2>', '<Cmd>lua require \'util\'.do_search(false)<Cr>' .. '<Cmd>setl hlsearch<Cr>', {})
    k('v', '<F2>', '<Cmd>lua require \'util\'.do_search(true)<Cr>' .. '<Esc>' .. '<Cmd>setl hlsearch<Cr>', {})
    k('', '<F3>', '<Cmd>setl hlsearch!<Cr>', {})
    k('', '<F4>', '<Cmd>MarkClear<Cr>' .. '<Cmd>setl nohlsearch<Cr>', {})
end
--- }}}

-- christoomey/vim-tmux-navigator {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-tmux-navigator/plugin/tmux_navigator.vim')) == 0 then
    vim.g.tmux_navigator_no_mappings = 1

    k('', '<A-h>', '<Cmd>TmuxNavigateLeft<Cr>', { noremap = true, silent = true })
    k('', '<A-j>', '<Cmd>TmuxNavigateDown<Cr>', { noremap = true, silent = true })
    k('', '<A-k>', '<Cmd>TmuxNavigateUp<Cr>', { noremap = true, silent = true })
    k('', '<A-l>', '<Cmd>TmuxNavigateRight<Cr>', { noremap = true, silent = true })
    k('', '<A-\\>', '<Cmd>TmuxNavigatePrevious<Cr>', { noremap = true, silent = true })
end
-- }}}
