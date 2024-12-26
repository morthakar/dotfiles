function dev --wraps='tmux new-session' --description 'Creates or switches to a tmux session'
	set -g dir $(fd . "$HOME/code" -t d -d 2 | fzf)
	set -g session $(basename "$dir" | tr . _)

	tmux has-session -t "$session" > /dev/null 2>&1
	set -g exit_code "$status"

	if test -n "$TMUX"
		if test "$exit_code" -eq 0
			tmux switch-client -t "$session"
		else
			tmux new-session -d -s "$session" -c "$dir"
			tmux switch-client -t "$session"
		end
	else
		if test "$exit_code" -eq 0
			tmux attach-session -t "$session"
		else
			tmux new-session -A -s "$session" -c "$dir"
		end
	end
end


