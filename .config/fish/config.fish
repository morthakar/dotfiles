 if status --is-login
	 #exec Hyprland &> /dev/null
 end

 # Qt
 #set --export QT_AUTO_SCREEN_SCALE_FACTOR 1
 #set --export QT_QPA_PLATFORM wayland
 #set --export QT_WAYLAND_DISABLE_WINDOWDECORATION 1
 #set --export QT_QPA_PLATFORMTHEME qt5ct

 set -g --export EDITOR nvim
 set -g --export DOTFILE "$HOME"/dotfiles

if status is-interactive
	# Commands to run in interactive sessions can go here
	bind \cf 'fuzzy-find; commandline -f repaint'
end

starship init fish | source
zoxide init --cmd cd fish | source

