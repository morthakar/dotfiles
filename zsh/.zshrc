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

# Defaults
alias vim="$EDITOR"
alias n="$EDITOR"
alias ls="exa -la --icons --group-directories-first"

# Edit Cfg
alias dot="cd $DOTFILES"
alias ze="$EDITOR $HOME/.zshrc"
alias ne="$EDITOR $HOME/.config/nvim/init.lua"
alias te="$EDITOR $HOME/.config/tmux/tmux.conf"

# System Management
alias up="paru -Syu --noconfirm" # update standard pkgs and AUR pkgs (paru)
alias unlock="sudo rm /var/lib/pacman/db.lck" # remove pacman lock
alias cleanup="pacman -Qtdq | pacman -Rns -" # remove orphaned packages
alias pm="pacman -Qq | fzf --preview 'pacman -Qil {}' \
  --layout=reverse --bind 'enter:execute(pacman -Qil {} | bat)'"
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
  local dir=$(fd ${1} -H -E .git -E .cache -E .local| fzf)
  if [[ -d "$dir" ]] ; then
      cd "$dir"
    elif [[ -n "$dir" ]] ; then
      "$EDITOR" "$dir"
  fi
}

# Find All - find all entires in the root directory and cd to it.
fa() {
  local dir=$(fd . / -H | fzf)
  if [[ -d "$dir" ]] ; then
      cd "$dir"
  else
      cd $(dirname "$dir")
  fi
}

# Find all files in the $DOTFILES directory and use the $EDITOR to edit.
cfg() {
  local file=$(fd . "$DOTFILES" -t f -H -E .git | fzf)
  if [[ -n "$file" ]] ; then
      "$EDITOR" "$file"
  fi
}


eval "$(starship init zsh)"
