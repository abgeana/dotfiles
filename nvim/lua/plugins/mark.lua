return {
    'abgeana/vim-mark',

    init = function()
        vim.g.mwDefaultHighlightingPalette = 'maximum'
    end,

    config = function()
        local get_visual_selection = function()
            -- function used to get the visual selection
            -- https://github.com/neovim/neovim/pull/21115#issuecomment-1320900205
            local _, ls, cs, _ = unpack(vim.fn.getpos 'v') -- start of the visual area
            local _, le, ce, _ = unpack(vim.fn.getpos '.') -- cursor position

            return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
        end

        local do_search = function()
            local current_mode = vim.fn.mode()

            -- TODO:
            -- use the mode() function to verify whether the current selection is a regular, line or block selection
            -- currently only works with regular visual selections

            if current_mode == 'n' then
                vim.fn.setreg('/', vim.fn.expand '<cword>')
            elseif current_mode == 'v' then
                vim.fn.setreg('/', get_visual_selection())
                -- feed <Esc> to enter normal mode afterwards
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'm', false)
            end

            vim.opt_local.hlsearch = true
        end

        vim.keymap.set('', '<F1>', '<Leader>m', { remap = true })
        vim.keymap.set('n', '<F2>', do_search)
        vim.keymap.set('v', '<F2>', do_search)
        vim.keymap.set('n', '<F3>', '<Cmd>set hlsearch!<Cr>')
        vim.keymap.set('', '<F4>', '<Cmd>MarkClear<Cr>' .. '<Cmd>setl nohlsearch<Cr>')
    end,

    dependencies = {
        'inkarkat/vim-ingo-library',
    },
}
