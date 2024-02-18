function ts
	set -f dir $(fd . "$HOME" -t d -H | fzf)
	set -f session $(basename "$dir" | tr . _)

	if has_client
		create_or_attach "$session" "$dir"
	else if not has_client && not has_session "$session" 
		create_and_switch "$session" "$dir"
	end
end

function create_or_attach
	if has_session "$argv[1]"
		tmux attach -t "$argv[1]"
	else
		tmux new-session -d -s "$argv[1]" -c "$argv[2]"
		tmux attach -t "$argv[1]"
	end
end

function create_and_switch
	tmux new-session -d -s "$argv[1]" -c "$argv[2]"
	tmux switch-client -t "$argv[1]"
end

function has_client
	test -z "$TMUX"
end

function has_session
	tmux has -t "$argv[1]" 2> /dev/null
end
