-- map vs. remap vs. noremap - http://stackoverflow.com/questions/3776117
-- remap is a boolean (true by default) which makes mappings recursive
-- one way to view the mappings currently set is to execute one of the commands
--     verbose map
--     verbose imap
--     verbose nmap

local k = vim.api.nvim_set_keymap

-- define the leader to space
-- the final value of mapleader must be set before any map commands use it
k('', ',', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- to disable autoindentation and autocommenting press F5, to enable it back press F6
k('', '<F5>', '<Cmd>set formatoptions-=cro nocindent noautoindent nosmartindent inde=<Cr>', {})
k('', '<F6>', '<Cmd>set formatoptions+=cro nocindent autoindent smartindent inde=    <Cr>', {})

-- move cursor on wrapped lines
k('', '<S-k>', 'gk', { noremap = true, silent = true })
k('', '<S-j>', 'gj', { noremap = true, silent = true })

-- move the complete window
k('n', '<C-k>', '<C-y>', { noremap = true, silent = true })
k('n', '<C-j>', '<C-e>', { noremap = true, silent = true })

-- remap <Leader><Esc> to <C-\><C-n> for neovim
-- see also ":help terminal" or ":help CTRL-\_CTRL-N"
k('t', '<Leader><Leader>', '<C-\\><C-n>', { noremap = true })
