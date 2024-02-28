function nrd --wraps='nordvpn' --description 'alias nrd=nordvpn'
	if test -z $argv
		nordvpn status
	else if test $argv = "c"
		sudo systemctl enable nordvpnd.service --now
		nordvpn $argv; 
		nordvpn set killswitch 1
	else if test $argv = "d"
		nordvpn $argv; 
		nordvpn set killswitch 0
		sudo systemctl disable nordvpnd.service --now
	end
end
