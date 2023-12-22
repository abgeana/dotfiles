return {
    'troydm/zoomwintab.vim',

    config = function()
        vim.g.zoomwintab_remap = 0

        vim.keymap.set('n', '<Leader>z', [[<Cmd>ZoomWinTabToggle<Cr>]], {})
    end,
}
