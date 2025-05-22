function ls --wraps='eza' --description 'alias ls=eza -lag@H --icons --group-directories-first'
	eza -lag@oH --icons --group-directories-first $argv
end
