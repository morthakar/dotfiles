function ls --wraps='eza -la' --wraps='eza -lag@H --icons --group-directories-first' --description 'alias ls=exa -lag@H --icons --group-directories-first'
	#command ls
	eza -lag@oH --icons --group-directories-first $argv; 
end
