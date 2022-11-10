# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$PATH:/usr/local/go/bin
#export PATH=$PATH:/home/dref/.cargo/bin/
export EDITOR="nvim"
export LANG=pt_BR.UTF-8
export DOTFILES="$HOME/dotfiles"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# bind CTRL + f to call function.
bindkey -s '^f' 'fa\n'

# Defaults
alias vim="$EDITOR"
alias n="$EDITOR"
alias ls="exa -lagF@H --icons --group-directories-first"

# Tmux
alias tsq="tmux kill-server"
alias tsk="tmux kill-session"

# System Management
alias up="yay -Syu && polybar-msg cmd restart" # update standard pkgs and AUR pkgs
alias unlock="sudo rm /var/lib/pacman/db.lck" # remove pacman lock
alias cleanup="sudo pacman -Qtdq | sudo pacman -Rns -" # remove orphaned packages
alias cleancache="paccache -r && yay -Scc"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias po="systemctl poweroff"
alias jctl="journalctl -p 3 -xb" #get the error messages from journalctl

#add new fonts
alias update-fc="sudo fc-cache -fv"

# Extractor for all kinds of archives
function ex ()
{
	(mkdir /tmp/$1)
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   sudo tar xjf $1  ;;
      *.tar.gz)    sudo tar xzf $1  ;;
      *.bz2)       sudo bunzip2 $1  ;;
      *.rar)       sudo unrar x $1  ;;
      *.gz)        sudo gunzip $1   ;;
      *.tar)       sudo tar xf $1   ;;
      *.tbz2)      sudo tar xjf $1  ;;
      *.tgz)       sudo tar xzf $1  ;;
      *.zip)       sudo unzip $1    ;;
      *.Z)         sudo uncompress $1 ;;
      *.7z)        sudo 7z x $1 ;;
      *.deb)       sudo ar x $1 ;;
      *.tar.xz)    sudo tar xf $1 -C /tmp/$1 ;;
      *.tar.zst)   sudo tar xf $1 ;;
      *)           echo ""$1" cannot be extracted via ex()" ;;
     esac
   else
     echo ""$1" is not a valid file"
   fi
 }


#  Fzf
#export FZF_DEFAULT_COMMAND="fd -H -E '.git' --type f"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# Find All - find all entires in the root directory and cd to it.
function fa() {
    local dir=${1:-"$HOME"}
	local search=$(fd . $dir -H | fzf --prompt "$dir " \
             --header 'CTRL-d: Dir | CTRL-f: Files' \
			 --bind "ctrl-d:change-prompt(Dir > )+reload(fd . $dir -t d -H)" \
			 --bind "ctrl-f:change-prompt(Files > )+reload(fd . $dir -t f -H)")

     if [[ -d "$search" ]] ; then
          cd "$search"

     elif [[ -f "$search" ]] ; then
		 cd $(dirname "$search")
          "$EDITOR" "$search"
      fi

}

function tmux_create_sesssion() {
	tmux new-session -d -s $session -c $dir #-n ${3:-"$EDITOR"}
#	tmux new-window -n run -d -t "$1" -c "$2"
#	tmux send -t "$1:1" "$EDITOR" Enter
#	tmux send -t "$1:2" "ls" Enter
}

function ts() {
    #local search=${1:-"$HOME"}
    local dir=${1:-"$(fd . "$HOME" -t d -H | fzf)"}
    local session=$(basename "$dir" | tr . _)

	if [[ !  -d "$dir" ]]; then
		return
	fi

	if [[ -z "$TMUX"  ]]; then
		if tmux has -t "$session" 2> /dev/null; then
			tmux attach -t "$session"
		else
			tmux_create_sesssion "$session" "$dir"
			tmux attach -t "$session"
		fi
	elif [[ -n "$TMUX" ]]; then
		if ! tmux has -t "$session" 2> /dev/null; then
			tmux_create_sesssion "$session" "$dir"
			tmux switch-client -t "$session"
		fi
	fi
    return
}

# Manage Packages
function pm() {
    pacman -Qeq | fzf \
    --prompt 'Package Manager> ' \
    --height '55%' \
    --preview 'pacman -Qei {}' \
    --bind 'ctrl-d:change-prompt(AUR> )+reload(pacman -Qqm)' \
    --bind 'ctrl-f:change-prompt(Native> )+reload(pacman -Qqn)' \
    --bind 'enter:execute(pacman -Ql {} | fzf)'
}

function pma() {
    pacman -Qq | fzf \
    --prompt 'Package Manager> ' \
    --height '55%' \
    --preview 'pacman -Qi {}' \
    --bind 'ctrl-d:change-prompt(AUR> )+reload(pacman -Qqm)' \
    --bind 'ctrl-f:change-prompt(Native> )+reload(pacman -Qqn)' \
    --bind 'enter:execute(pacman -Ql {} | fzf)'
}


eval "$(starship init zsh)"
