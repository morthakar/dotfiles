function ts --wraps='tmux new-session' --description 'Creates a tmux session in the cwd'
	set -g dir $(pwd)
	set -g session $(basename "$dir" | tr . _)

	set -g exit_code "$status"

	if test -z "$TMUX"
		tmux new-session -A -s "$session" -c "$dir"
	end
end


