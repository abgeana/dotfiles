" split the current tmux window and add a pane below then cd to the cwd
function TmuxPaneBelow()
    silent exec '!tmux split-window -v -p 20'
    silent exec '!tmux send-keys -t 1 "cd ' . getcwd() . '"'
    silent exec '!tmux send-keys -t 1 Enter'
endfunction

map <C-w>t :call TmuxPaneBelow()<CR>
