if status is-login && test -z $TMUX
	exec Hyprland &> /dev/null
end

 set -g --export EDITOR nvim
 set -g --export DOTFILE "$HOME"/dotfiles

if status is-interactive
	bind \cf 'fuzzy-find; commandline -f repaint'
end

starship init fish | source
zoxide init --cmd cd fish | source


