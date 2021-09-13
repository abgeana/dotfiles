local M = {}

function M.get_visual_selection()
    -- function used to get the visual selection
    -- https://stackoverflow.com/questions/1533565

    local _, lnum1, col1, _ = unpack(vim.fn.getpos("'<"))
    local _, lnum2, col2, _ = unpack(vim.fn.getpos("'>"))

    local lines = vim.fn.getline(lnum1, lnum2)
    
    -- we now have the selected lines, but the start and end lines 
    -- contain all characters including those outside the selection
    -- the first and last lines must be trimmed
    -- the trimming of the last line is based on the 'selection' option
    -- we first trim the end of the last line, in case the first line is the same as the last
    -- TODO:
    -- use the mode() function to verify whether the current selection is a regular, line or block selection
    -- currently this function assumes and works only with regular selection mode
    if vim.o.selection == 'inclusive' then
        lines[#lines] = string.sub(lines[#lines], 1, col2)
    else
        lines[#lines] = string.sub(lines[#lines], 1, col2 - 1)
    end
    -- next we trim the start of the first line
    lines[1] = string.sub(lines[1], col1)

    return vim.fn.join(lines, '\n')
end

function M.do_search(visual)
    -- function used to search 
    --     the word under the cursor in normal mode or
    --     a selected text snippet in visual mode
    -- there needs to be a way to tell the function if we are in normal or visual mode
    -- the 'visual' argument is set to different values in the key mapping depending
    --     false when the function is called from normal mode
    --     true when the function is called from visual mode
    -- https://vi.stackexchange.com/questions/8789
    -- https://vi.stackexchange.com/questions/8335

    if visual == true then
        -- the function is called from visual mode (i.e. vmap)
	-- which actually exits visual mode to execute the command
	-- as a result, we get back into visual mode
	vim.cmd('normal! gv')
    end

    local current_mode = vim.fn.mode()

    -- TODO:
    -- use the mode() function to verify whether the current selection is a regular, line or block selection
    -- currently only works with regular visual selections

    if current_mode == 'n' then
	vim.fn.setreg('/', vim.fn.expand('<cword>'))
    elseif current_mode == 'v' then
        vim.fn.setreg('/', M.get_visual_selection())
    end
end

function M.termcode(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

return M
