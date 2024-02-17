function findfiles
	set -f dir $HOME
	set -f search (fd . "$dir" -H | fzf --prompt "$dir " --header "CTRL-d: Dir | CTRL-f: Files" --bind "ctrl-d:change-prompt(Dir > )+reload(fd . $dir -t d -H)" --bind "ctrl-f:change-prompt(Files > )+reload(fd . $dir -t f -H)")

	if test -d "$search"
		cd "$search"
	else if test -f "$search"
		"$EDITOR" "$search"
	end
end
