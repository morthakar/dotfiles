function ls --wraps='exa -la' --wraps='exa -lag@H --icons --group-directories-first' --description 'alias ls=exa -lag@H --icons --group-directories-first'
	#command ls
	exa -lag@H --icons --group-directories-first $argv; 
end
