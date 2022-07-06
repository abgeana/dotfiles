-- make all buffers in all windows
vim.cmd('autocmd BufWinEnter * :set relativenumber number')

-- set indentation of 2 spaces for yaml files
vim.cmd('autocmd FileType yaml IndentWidth 2')

-- use this to keep folds in sync between different windows displaying the same buffer
vim.cmd('autocmd BufLeave * :mkview')
vim.cmd('autocmd WinLeave * :mkview')
