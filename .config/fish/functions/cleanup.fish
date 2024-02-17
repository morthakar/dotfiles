function cleanup --wraps='paccache -r && yay -Scc && sudo pacman -Qtdq | sudo pacman -Rns -' --description 'alias cleanup=paccache -r && yay -Scc && sudo pacman -Qtdq | sudo pacman -Rns -'
  paccache -r && paru -Scc && yay -Scc && sudo pacman -Qtdq | sudo pacman -Rns - $argv; 
end
