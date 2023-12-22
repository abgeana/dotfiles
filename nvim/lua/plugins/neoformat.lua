return {
    'sbdchd/neoformat',

    config = function()
        vim.keymap.set('n', '<A-f>', '<Cmd>Neoformat<Cr>', { silent = true })
    end,
}
