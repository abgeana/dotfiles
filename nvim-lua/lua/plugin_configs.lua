-- vim: foldmethod=marker

local k = vim.api.nvim_set_keymap
local bk = vim.api.nvim_buf_set_keymap

--- alegen/vim-mark {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-mark/plugin/mark.vim')) == 0 then
    -- use a proper palette
    vim.g.mwDefaultHighlightingPalette = 'maximum'
    -- if the mark plugin is available use it together with
    -- the regular search highlighting
    k('',  '<F1>', '<Leader>m', {})
    k('n', '<F2>', '<Cmd>lua require \'util\'.do_search(false)<Cr>' .. '<Cmd>setl hlsearch<Cr>', {})
    k('v', '<F2>', '<Cmd>lua require \'util\'.do_search(true)<Cr>' .. '<Esc>' .. '<Cmd>setl hlsearch<Cr>', {})
    k('',  '<F3>', '<Cmd>setl hlsearch!<Cr>', {})
    k('',  '<F4>', '<Cmd>MarkClear<Cr>' .. '<Cmd>setl nohlsearch<Cr>', {})
end
--- }}}

-- Shougo/defx.nvim {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/defx.nvim/plugin/defx.vim')) == 0 then
    k('', '<A-x>',   [[<Cmd>Defx<Cr>]], {})
    k('', '<A-S-x>', [[<Cmd>Defx -search=`expand('%:p')` `getcwd()`<Cr>]] , {})

    vim.fn['defx#custom#option']('_', {
        split       = 'vertical',
        winwidth    = 50,
        direction   = 'topleft',
        listed      = 1,
        resume      = 1,
        toggle      = 1
    })

    vim.cmd('autocmd FileType defx call v:lua.defx_settings()')
    _G.defx_settings = function()
        local defx_key = function(key, expr)
            bk(0, 'n', key, expr, { noremap = true, silent = true, expr = true })
        end

        defx_key('<Cr>', [[ defx#is_directory() ? defx#do_action('open_tree', 'toggle') :  defx#do_action('multi', ['drop', 'quit']) ]])

        defx_key('h', [[ defx#do_action('cd', ['..'])        ]])
        defx_key('j', [[ line('.') == line('$') ? 'gg' : 'j' ]])
        defx_key('k', [[ line('.') == 1 ? 'G' : 'k'          ]])
        defx_key('l', [[ defx#do_action('open')              ]])

        defx_key('s', [[ defx#do_action('multi', [['drop', 'split'], 'quit'])  ]])
        defx_key('v', [[ defx#do_action('multi', [['drop', 'vsplit'], 'quit']) ]])

        defx_key('o',     [[ defx#do_action('open_tree', 'toggle')  ]])
        defx_key('!',     [[ defx#do_action('execute_command')      ]])
        defx_key('yy',    [[ defx#do_action('yank_path')            ]])
        defx_key('.',     [[ defx#do_action('toggle_ignored_files') ]])
        defx_key('<C-l>', [[ defx#do_action('redraw')               ]])
        defx_key('~',     [[ defx#do_action('cd')                   ]])
        defx_key('cd',    [[ defx#do_action('change_vim_cwd')       ]])
    end
end
-- }}}

-- justinmk/vim-sneak {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-sneak/plugin/sneak.vim')) == 0 then
    -- use labels for jump spots
    vim.g['sneak#label'] = 1
    -- press "s" to go to the next match
    vim.g['sneak#s_next'] = 1
    -- case sensitivity determined by ignorecase and smartcase
    vim.g['sneak#use_ic_scs'] = 1
end
-- }}}

-- plasticboy/vim-markdown {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-markdown/ftplugin/markdown.vim')) == 0 then
    vim.g['vim_markdown_folding_disabled'] = 1
    -- https://github.com/plasticboy/vim-markdown#concealing
    vim.cmd('autocmd FileType markdown setlocal conceallevel=2')
end
-- }}}

-- inkarkat/vim-DeleteTrailingWhitespace {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-DeleteTrailingWhitespace/plugin/DeleteTrailingWhitespace.vim')) == 0 then
    -- i want to eradicate all trailing spaces all the time
    vim.g['DeleteTrailingWhitespace'] = 1
    -- automatically do it for me when i save a file
    vim.g['DeleteTrailingWhitespace_Action'] = 'delete'
end
-- }}}

-- christoomey/vim-tmux-navigator {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-tmux-navigator/plugin/tmux_navigator.vim')) == 0 then
    vim.g.tmux_navigator_no_mappings = 1

    k('', '<A-h>',  '<Cmd>TmuxNavigateLeft<Cr>',     { noremap = true, silent = true })
    k('', '<A-j>',  '<Cmd>TmuxNavigateDown<Cr>',     { noremap = true, silent = true })
    k('', '<A-k>',  '<Cmd>TmuxNavigateUp<Cr>',       { noremap = true, silent = true })
    k('', '<A-l>',  '<Cmd>TmuxNavigateRight<Cr>',    { noremap = true, silent = true })
    k('', '<A-\\>', '<Cmd>TmuxNavigatePrevious<Cr>', { noremap = true, silent = true })
end
-- }}}

-- google/vim-codefmt {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-codefmt/autoload/codefmt.vim')) == 0 then
    k('n', '<A-f>', '<Cmd>FormatCode<Cr>', { noremap = true, silent = true })
    -- change default formatter for javascript buffers from clang-format to js-beautify
    -- https://github.com/google/vim-codefmt/blob/0bf16eb74e8243ee477ad97330e451026311fbae/instant/flags.vim#L24
    -- https://github.com/google/vim-codefmt/blob/78f646545c4e1254fc413242e5c204a2dc79665d/vroom/main.vroom#L137
    vim.cmd('autocmd FileType javascript let b:codefmt_formatter="prettier"')
end
-- }}}

-- inkarkat/vim-SyntaxRange {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-SyntaxRange/plugin/SyntaxRange.vim')) == 0 then
    vim.cmd([[ autocmd Syntax * call SyntaxRange#Include('@begin=lua@', '@end=lua@', 'lua', 'NonText') ]])
end
-- }}}

-- neovim/nvim-lspconfig {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/nvim-lspconfig/plugin/lspconfig.vim')) == 0 then
    require('lsp')
    lsp_setup()
end
-- }}}

-- neovim/vim-coverage {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/vim-coverage/plugin/coverage.vim')) == 0 then
    -- to get the maktaba plugin, use
    --   let coverage_plugin=maktaba#plugin#Get('coverage')
    -- after which you can configure the gcov plugin via
    --   let coverage_plugin.globals._gcov_temp_search_paths = ['...']
    --   let coverage_plugin.globals._gcov_temp_file_patterns = ['...']
end
-- }}}

-- nvim-telescope/telescope.nvim {{{
if vim.fn.empty(vim.fn.glob('~/.config/nvim/plugged/telescope.nvim/plugin/telescope.vim')) == 0 then
    k('n', '<Leader>ff',   [[<Cmd>Telescope find_files<Cr>]], {})
    k('n', '<Leader>fg',   [[<Cmd>Telescope live_grep<Cr>]], {})
    k('n', '<Leader>fb',   [[<Cmd>Telescope buffers<Cr>]], {})
    k('n', '<Leader>fh',   [[<Cmd>Telescope help_tags<Cr>]], {})
end
-- }}}
