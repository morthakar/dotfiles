function clean-cache --description 'alias cleanup=paccache -r && yay -Scc && sudo pacman -Qtdq | sudo pacman -Rns -'
	sudo pacman -Sc --noconfirm
	paccache -rk1 
	paru -Sc --noconfirm
	yay -Sc --noconfirm
end
