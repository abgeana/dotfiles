return {
    'inkarkat/vim-DeleteTrailingWhitespace',

    config = function()
        -- check whether the file is open in binary mode or not
        if vim.o.binary == false then
            vim.g['DeleteTrailingWhitespace'] = 1
            vim.g['DeleteTrailingWhitespace_Action'] = 'delete'
        end
    end,
}
