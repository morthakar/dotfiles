function up --wraps='paru -Syu && polybar-msg cmd restart' --description 'alias up=paru'
	begin
		 paru -Syu || yay -Syu 
		 killall waybar &>/dev/null 
		 hyprctl dispatch exec waybar 
	end
end
