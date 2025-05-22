function fuzzy-find --argument dir
	set -f dir "$HOME"
	set -f result (fd . "$dir" -H | \
	fzf --prompt "Search: " \
	--header "Base Directory: $dir")

	if test -d "$result"
		cd "$result"
	else if test -f "$result"
		"$EDITOR" "$result"
	end
end


