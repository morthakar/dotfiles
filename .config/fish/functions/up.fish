function up --wraps='paru -Syu && polybar-msg cmd restart' --description 'alias up=paru'
  ~/dotfiles/script archtools rankmirrors -n 20 -p 200 --treshold 200 -t 250 -o /etc/pacman.d/mirrorlist
  paru -Syu &&
  killall waybar &>/dev/null
  hyprctl dispatch exec waybar
end
