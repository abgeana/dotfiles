return {
    'justinmk/vim-sneak',

    config = function()
        -- use labels for jump spots
        vim.g['sneak#label'] = 1
        -- press "s" to go to the next match
        vim.g['sneak#s_next'] = 1
        -- case sensitivity determined by ignorecase and smartcase
        vim.g['sneak#use_ic_scs'] = 1
    end,
}
