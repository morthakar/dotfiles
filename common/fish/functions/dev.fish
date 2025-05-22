function dev --wraps='tmux new-session' --description 'Creates or switches to a tmux session'

	switch $argv
	case ""
		set -f dir $(fd . "$HOME/code" -t d -d 2 | fzf)
	case "*"
		set -f dir $(fd . "$argv" -t d -d 2 | fzf)
	end

	if not test -d "$dir"
		set -f dir $(pwd)
	end

	set -f session $(basename "$dir" | tr . _)

	tmux has-session -t "$session" > /dev/null 2>&1
	set -f exit_code "$status"

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

