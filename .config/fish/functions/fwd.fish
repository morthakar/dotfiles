function fwd
	set -f dir (fd . "$PWD" -H -t d --exclude=.git | fzf)

	if test -n "$dir"
		cd "$dir"
	end
end
