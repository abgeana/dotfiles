return {
    'svrana/neosolarized.nvim',
    lazy = false,
    priority = 1000,

    config = function()
        require('neosolarized').setup {
            comment_italics = false,
        }

        vim.cmd("colorscheme neosolarized")
    end,

    dependencies = {
        'tjdevries/colorbuddy.nvim',
    },
}

-- The code below is for using a different solarized theme plugin.
-- I was testing a different plugin when checking the coloring bug that appears when the same buffer is opened in two
-- windows.

--return {
--    'maxmx03/solarized.nvim',
--    lazy = false,
--    priority = 1000,
--
--    config = function()
--        my_style = { italic = false, standout = false, bold = false }
--
--        require('solarized').setup({
--            highlights = function (colors, colorhelper)
--                return {
--                    Visual = my_style,
--                }
--            end,
--
--            styles = {
--                -- disable italics for everything
--                -- https://github.com/maxmx03/solarized.nvim/blob/6875d609077411c88d293cb0520ca4e08b829ded/lua/solarized/config.lua#L17-L26
--                comments = my_style, 
--                functions = my_style,
--                variables = my_style,
--                numbers = my_style,
--                constants = my_style,
--                parameters = my_style,
--                keywords = my_style,
--                types = my_style,
--            },
--        })
--
--        vim.o.background = 'dark'
--        vim.cmd.colorscheme 'solarized'
--    end,
--}
