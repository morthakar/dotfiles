function tsq --wraps='tmux kill-server' --description 'alias tsq=tmux kill-server'
  tmux kill-server $argv; 
end
