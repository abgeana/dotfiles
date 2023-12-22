-- map vs. remap vs. noremap - http://stackoverflow.com/questions/3776117
--
-- remap is a boolean (true by default) which makes mappings recursive
-- map and noremap are recursive and non-recursive versions of mappings
--
-- examples
--     :map j gg        moves the cursor to the first line
--     :map Q j         moves the cursor to the first line because map is recursive
--     :noremap W j     moves the cursor down one line because noremap is non-recursive
--
-- vim is a modal editor, so there are commands for various modes such as
--     :map and :noremap         applies to normal, visual and select modes
--     :nmap and :nnoremap       applies to normal mode only
--     :imap and :inoremap       applies to insert mode only
--     :xmap and :xnoremap       applies to visual mode only
--
-- in addition, there are also a bunch of arguments to the map commands (:help map-arguments)
-- the 'silent' (:help map-silent) argument is used to define a mapping that will not echo
--
-- one way to view the mappings currently set is to execute one of the commands
--     verbose map
--     verbose imap
--     verbose nmap

-- the ',' is configured as the leader
-- turn presses of this key into a nop
vim.keymap.set({ 'n', 'v' }, ',', '<Nop>', { silent = true })

-- to disable autoindentation and autocommenting press F5, to enable it back press F6
vim.keymap.set('', '<F5>', '<Cmd>set formatoptions-=jcroql nocindent noautoindent nosmartindent inde=<Cr>')
vim.keymap.set('', '<F6>', '<Cmd>set formatoptions+=jcroql nocindent autoindent smartindent inde=    <Cr>')

-- remap for dealing with word wrap
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- move the complete window
vim.keymap.set('', '<C-k>', '<C-y>', { silent = true })
vim.keymap.set('', '<C-j>', '<C-e>', { silent = true })

-- remap <Leader><Esc> to <C-\><C-n> for neovim
-- see also ":help terminal" or ":help CTRL-\_CTRL-N"
vim.keymap.set('t', '<Leader><Leader>', '<C-\\><C-n>', { noremap = true })

-- diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<Leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
