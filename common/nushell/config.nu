alias n = nvim
alias vim = nvim

def pm [] {
	pacman -Qq | 
	fzf --header 'All(F1) Installed(F2) AUR(F3) Dependecies(F4)' --prompt 'All> ' --height '100%' --preview 'pacman -Qi {}' --bind 'f1:change-prompt(All> )+reload(pacman -Qq)' --bind 'f2:change-prompt(Installed> )+reload(pacman -Qeq)' --bind 'f3:change-prompt(AUR> )+reload(pacman -Qqm)' --bind 'f4:change-prompt(Depencies> )+reload(pacman -Qdq)' --bind 'enter:execute(pacman -Ql {} | fzf)'
}

def dev [dir: string] {
	mut path = ""
		match dir {
		"." => path = $(pwd)
		"" => path = $(fd . "$HOME/code" -t d -d 2 | fzf)
		_ => path = $(fd -t d -H "$argv"  "$HOME" | fzf) 
	}
}

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
