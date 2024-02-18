function nrd --wraps='nordvpn' --description 'alias nrd=nordvpn'
	if test -z $argv
		nordvpn status
	else if test $argv = "c"
		nordvpn $argv; 
		nordvpn set killswitch 1
	else if test $argv = "d"
		nordvpn $argv; 
		nordvpn set killswitch 0
	end
end
