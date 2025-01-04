 if status --is-login
	 #exec Hyprland &> /dev/null
 end

if status is-interactive
	# Commands to run in interactive sessions can go here
	bind \cf 'findfiles; commandline -f repaint'
end

starship init fish | source

 # Qt
set --export QT_AUTO_SCREEN_SCALE_FACTOR 1
set --export QT_QPA_PLATFORM wayland
set --export QT_WAYLAND_DISABLE_WINDOWDECORATION 1
set --export QT_QPA_PLATFORMTHEME qt5ct

