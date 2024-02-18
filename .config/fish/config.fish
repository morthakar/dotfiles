if status --is-login
	if test -z "$DISPLAY" -a $XDG_VTNR = 1
		exec startx --vt1 &> /dev/null
	end
end

if status is-interactive
	# Commands to run in interactive sessions can go here
	bind \cf 'findfiles; commandline -f repaint'
end

starship init fish | source
