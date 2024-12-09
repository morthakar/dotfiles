#!/bin/bash

dir=$(fd . "$HOME/code" -t d -d 2 | fzf)

session=$(basename "$dir" | tr . _)

if tmux has-session -t "$session" 2>/dev/null; then
    if [[ -n $TMUX ]]; then
        tmux switch-client -t "$session"
    else
        tmux attach-session -t "$session"
    fi
else
    if [[ -n $TMUX ]]; then
        tmux new-session -d -s "$session" -c "$dir"
        tmux switch-client -t "$session"
    else
        tmux new-session -A -s "$session" -c "$dir"
    fi
fi

