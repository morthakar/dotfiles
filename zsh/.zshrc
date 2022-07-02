# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/dref/.cargo/bin/
export EDITOR="nvim"
export LANG=pt_BR.UTF-8
export DOTFILES="$HOME/.dotfiles"

bindkey -s '^f' 'find_all\n'

# Defaults
alias vim="$EDITOR"
alias n="$EDITOR"
alias ls="exa -la --icons --group-directories-first"

# System Management
alias up="sudo pacman -Syu && paru -Syu --noconfirm" # update standard pkgs and AUR pkgs (paru)
alias unlock="sudo rm /var/lib/pacman/db.lck" # remove pacman lock
alias cleanup="sudo pacman -Qtdq | sudo pacman -Rns -" # remove orphaned packages
#alias pm="pacman -Qeq | fzf --preview 'pacman -Qei {}' --layout=reverse \
#  --bind 'enter:execute(pacman -Ql {} | fzf)' --height 55%"
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias po="systemctl poweroff"
alias jctl="journalctl -p 3 -xb" #get the error messages from journalctl

#add new fonts
alias update-fc="sudo fc-cache -fv"

# Functions
# ex = Extractor for all kinds of archives
ex ()
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

# Find - find entries in the current directory, excluding some directories.
f() {
    local dir="/"
    local search=$(fd . $dir -H | fzf)
    if [[ -d "$search" ]] ; then
        cd "$search"
      elif [[ -n "$search" ]] ; then
        "$EDITOR" "$search"
    fi
}

# Find All - find all entires in the root directory and cd to it.
find_all() {
    local dir=$HOME
    local search=$(fd . $dir -H | fzf --prompt 'DOTFILES> ' \
             --header 'CTRL-D: Directories / CTRL-F: Files' \
             --bind 'ctrl-d:change-prompt(Directories> )+reload(fd . $dir -t d -H)' \
             --bind 'ctrl-f:change-prompt(Files> )+reload(fd . $dir -t f -H)')

     if [[ -d "$search" ]] ; then
          cd "$search"

     elif [[ -n "$search" ]] ; then
          "$EDITOR" "$search"
      fi

}

# Manage Packages
pm() {
    pacman -Qeq | fzf \
    --prompt 'Package Manager> ' \
    --height '55%' \
    --preview 'pacman -Qei {}' \
    --bind 'ctrl-d:change-prompt(AUR> )+reload(pacman -Qqm)' \
    --bind 'ctrl-f:change-prompt(Native> )+reload(pacman -Qqn)' \
    --bind 'enter:execute(pacman -Ql {} | fzf)'
}

testt() {
    LC_ALL=C.UTF-8 pacman -Qi | awk '\
    /^Name/{name=$3} \
    /^Installed Size/{size=$3} \
    {print size, name}' \
    | sort -h
}
eval "$(starship init zsh)"

