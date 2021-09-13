-- improve the vim completion menu with some custom remappings
-- https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
-- https://vim.fandom.com/wiki/Improve_completion_popup_menu
-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
-- https://github.com/nanotee/nvim-lua-guide#vimapinvim_replace_termcodes

local util = require 'util'

local k = vim.api.nvim_set_keymap
local t = util.termcode

-- when more than one match, list all matches and complete till longest common string
vim.o.wildmenu = true

-- complete only up to point of ambiguity
vim.o.wildmode = 'longest:full'

-- configure the completion menu
--     menuone - use the popup menu also when there is only one match
--     longest - only insert the longest common text of the matches
vim.o.completeopt = 'menuone,longest'

-- change the behavior of the enter key when the completion popup menu is visible to select the entry
_G.pop_up_menu_select = function() 
    if vim.fn.pumvisible() == 1 then
        -- the pop up menu is visible
	-- so we accept the selected option and stop completion
	-- see also 'help popupmenu-keys'
	return t('<C-y>')
    else
        return t('<C-r>')
    end
end
k('i', '<Cr>', 'v:lua.pop_up_menu_select()', { noremap = true, expr = true })

-- after the pop um menu appears, select the first option such that i may directly press enter if the first match is correct
_G.pop_up_menu_open = function()
    if vim.fn.pumvisible() == 0 then
        return t('<C-n>') .. t('<Down>')
    else
        return t('<C-n>')
    end
end
k('i', '<C-n>', 'v:lua.pop_up_menu_open()', { noremap = true, expr = true })
