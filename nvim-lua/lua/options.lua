-- allow buffers with changes to be hidden
-- http://usevim.com/2012/10/19/vim101-set-hidden/
vim.o.hidden = true

-- disable the mouse completely
vim.o.mouse = ''

-- use manual folding and show the fold column
vim.o.foldmethod = 'manual'
vim.o.foldcolumn = '1'

-- backspace behaviour
-- http://vim.wikia.com/wiki/Erasing_previously_entered_characters_in_insert_mode
vim.o.backspace = 'indent,eol,start'

-- dynamic indentation configuration
_G.indent_width_func = function(buffer, width_str)
    local width = tonumber(width_str)
    if buffer == 0 then
        vim.o.tabstop = width        -- control the number of space chars inserted when TAB is pressed
        vim.o.shiftwidth = width     -- the number of space characters inserted for indentation
        vim.o.softtabstop = width    -- stop at multiple of 4 when pressing TAB key
    else
        vim.bo.tabstop = width       -- control the number of space chars inserted when TAB is pressed
        vim.bo.shiftwidth = width    -- the number of space characters inserted for indentation
		vim.bo.softtabstop = width   -- stop at multiple of 4 when pressing TAB key
    end
end
vim.api.nvim_exec('command -nargs=1 IndentWidth call v:lua.indent_width_func(0, <f-args>)', false)
vim.api.nvim_exec('command -nargs=1 IndentWidthLocal call v:lua.indent_width_func(1, <f-args>)', false)

-- set indentation to 4 spaces
vim.api.nvim_command('IndentWidth 4')

-- insert space chars whenever TAB is pressed
vim.o.expandtab = true

-- autoindentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.cindent = false

-- searching
vim.o.incsearch = true              -- incremental search
vim.o.ignorecase = true             -- search ignoring case
vim.o.smartcase = true              -- do not ignore case if text has one capital letter
vim.o.hlsearch = false              -- start without highlighting the search item
vim.o.showmatch = true              -- show matching bracket
vim.o.diffopt = 'filler,iwhite'		-- ignore all whitespace and sync

-- show hybdrid line numbers (number and relativenumber)
vim.o.number = true
vim.o.relativenumber = true

-- shows what you are typing as a command
vim.o.showcmd = true

-- remember more undos
vim.o.undolevels = 5000

-- no bells
vim.o.errorbells = false

-- make a useful status line
vim.o.statusline = '[ buffer %n ] %F [%Y,%{&ff}] %m%r%h%=[ %l/%L , %v, %o ][ %p%% ]'

-- always show the status line
vim.o.laststatus = 2

-- avoid problems with esc key and meta key bindings
-- <esc>+key will be the same as <alt>+key if the delay between pressing <esc>
-- and key is less than the value in timeoutlen
vim.o.timeout = true
vim.o.ttimeout = false
vim.o.timeoutlen = 200

-- highlight the line on which the cursor is
vim.o.cursorline = true

-- when more than one match, list all matches and complete till longest common string
vim.o.wildmenu = true

-- complete only up to point of ambiguity
vim.o.wildmode = 'longest:full'

-- configure the completion menu
-- menuone - use the popup menu also when there is only one match
-- longest - only insert the longest common text of the matches
vim.o.completeopt = 'menuone,longest'

-- do not redraw too much
vim.o.lazyredraw = true

-- shada (SHAred DAta) configuration
-- default shada=!,'100,<50,s10,h
-- '1000     - 1000 files for which you have marks (a-z)
-- f1        - store global marks (A-Z and 0-9)
-- <500      - lines saved for each of the registers
-- h         - disable 'hlsearch' highlighting when starting
vim.o.shada = '\'500,f1,<500,h'

-- viewoptions settings recommended by vim-stay
-- :help vim-stay-viewoptions
--   cursor  cursor position in file and in window
--   folds   manually created folds, opened/closed folds and local fold options
--   slash   backslashes in file names replaced with forward slashes
--   unix    with Unix end-of-line format (single <NL>), even when on Windows or DOS
vim.o.viewoptions = 'cursor,folds,slash,unix'

-- show unprintable characters hexadecimal as <xx> instead of using ^C and ~C
vim.o.display = 'uhex'

-- configure how splitting works, to the right and below
vim.o.splitbelow = true
vim.o.splitright = true
