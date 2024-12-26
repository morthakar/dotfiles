function findfiles --argument dir
	set -q dir[1]; or set dir "$HOME"
	set -f result (fd . "$dir" -H -t d | \
	fzf --prompt "[$dir]\$" \
	--header "F1: Dir | F2: Files | F3: System | F4: Code" \
	# --preview "eza -I '.cache' {} -T" \
	--bind "f1:change-prompt(Dir > )+reload(fd . $dir -t d)" \
	--bind "f2:change-prompt(Files > )+reload(fd . $dir -t f -H)" \
	--bind "f3:change-prompt(System > )+reload(fd . / -H)" \
	--bind "f4:change-prompt(Code > )+reload(fd . $HOME/code -t d -H)")

	if test -d "$result"
		cd "$result"
	else if test -f "$result"
		"$EDITOR" "$result"
	end
end


