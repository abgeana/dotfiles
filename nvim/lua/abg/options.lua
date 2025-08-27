-- disable mouse mode
vim.o.mouse = ''

-- show foldcolumn with auto size up to a max of 5 levels
vim.o.foldcolumn = 'auto:5'

-- dynamic indentation configuration
_G.indent_width_func = function(buffer, width_str)
    local width = tonumber(width_str)
    if buffer == 0 then
        vim.o.tabstop = width -- control the number of space chars inserted when TAB is pressed
        vim.o.shiftwidth = width -- the number of space characters inserted for indentation
        vim.o.softtabstop = width -- stop at multiple of 4 when pressing TAB key
    else
        vim.bo.tabstop = width -- control the number of space chars inserted when TAB is pressed
        vim.bo.shiftwidth = width -- the number of space characters inserted for indentation
        vim.bo.softtabstop = width -- stop at multiple of 4 when pressing TAB key
    end
end
vim.cmd 'command -nargs=1 IndentWidth call v:lua.indent_width_func(0, <f-args>)'
vim.cmd 'command -nargs=1 IndentWidthLocal call v:lua.indent_width_func(1, <f-args>)'

-- set indentation to 4 spaces
vim.cmd 'IndentWidth 4'

-- insert space chars whenever TAB is pressed
vim.o.expandtab = true

-- autoindentation
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.cindent = false

-- searching
vim.o.incsearch = true -- incremental search
vim.o.ignorecase = true -- search ignoring case
vim.o.smartcase = true -- do not ignore case if text has one capital letter
vim.o.hlsearch = false -- start without highlighting the search item
vim.o.showmatch = true -- show matching bracket
vim.o.diffopt = 'filler,iwhite' -- ignore all whitespace and sync

-- show hybdrid line numbers (number and relativenumber)
vim.o.number = true
vim.o.relativenumber = true

-- remember more undos, even after closing neovim
vim.o.undolevels = 5000
vim.o.undofile = true

-- make a useful status line
vim.o.statusline = '[ buffer %n ] %F [%Y,%{&ff}] %m%r%h%=[ %l/%L, %v, %o ][ %p%% ]'

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

-- complete only up to point of ambiguity
vim.o.wildmode = 'longest:full'

-- configure the completion menu
vim.o.completeopt = 'menu,menuone,noinsert,popup,fuzzy'
vim.o.pumheight = 10

-- shada (SHAred DAta) configuration
-- default shada=!,'100,<50,s10,h
-- '1000     - 1000 files for which you have marks (a-z)
-- f1        - store global marks (A-Z and 0-9)
-- <500      - lines saved for each of the registers
-- h         - disable 'hlsearch' highlighting when starting
vim.o.shada = "'500,f1,<500,h"

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

-- configure the jumplist to behave as a stack
-- whenever performing a jump from the middle of the jumplist,
-- all entries after the current one are discarded
-- see also 'help jumplist-stack'
vim.o.jumpoptions = 'stack'

-- synt the clipboard between the system and neovim
-- this means no longer having to interact with the '+' or '*' registers
vim.o.clipboard = 'unnamedplus'

-- keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- decrease the time required to trigger an update of the swap file (default 4000)
vim.o.updatetime = 250

-- enable 24bit terminal gui colors
vim.o.termguicolors = true

-- set the background to dark
vim.o.background = 'dark'

-- Setting foldtext to the empty string enables syntax highlighting for the first fold line.
-- Otherwise, the first line would be something along the lines "xxxx lines: [actual first line]" in gray.
vim.o.foldtext = ""
vim.o.foldlevel = 99
