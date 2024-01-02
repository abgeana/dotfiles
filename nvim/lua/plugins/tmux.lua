return {
    'christoomey/vim-tmux-navigator',

    config = function()
        vim.g.tmux_navigator_no_mappings = 1
        vim.g.tmux_navigator_disable_when_zoomed = 1

        vim.keymap.set('', '<A-h>', '<Cmd>TmuxNavigateLeft<Cr>', { noremap = true, silent = true })
        vim.keymap.set('', '<A-j>', '<Cmd>TmuxNavigateDown<Cr>', { noremap = true, silent = true })
        vim.keymap.set('', '<A-k>', '<Cmd>TmuxNavigateUp<Cr>', { noremap = true, silent = true })
        vim.keymap.set('', '<A-l>', '<Cmd>TmuxNavigateRight<Cr>', { noremap = true, silent = true })
        vim.keymap.set('', '<A-\\>', '<Cmd>TmuxNavigatePrevious<Cr>', { noremap = true, silent = true })
    end,
}
