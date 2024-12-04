function ts
	set -g dir $(fd . "$HOME/code" -t d -d 2 | fzf)
	set -g session $(basename "$dir" | tr . _)

	if not test -z "$dir" && not test -z "$session"
		tmux new-session -A -s "$session" -c "$dir"
	end
end
