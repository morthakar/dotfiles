# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/dref/.cargo/bin/
export EDITOR="nvim"
# You may need to manually set your language environment
export LANG=pt_BR.UTF-8

# Alias
alias vim=nvim
alias dot="cd ~/.dotfiles/ && f"
alias zshe="nvim ~/.zshrc"
alias nvime="nvim ~/.config/nvim/init.vim"
alias tmuxe="nvim ~/.config/tmux/tmux.conf"
alias ls="lsa"
alias lsa="lsd -alh --group-dirs first"

 # Pacman 
 alias pacman="sudo pacman" # update only standard pkgs
 alias pacs="sudo pacman -Syyu" # update only standard pkgs
 alias pars="paru -Syu --noconfirm" # update standard pkgs and AUR pkgs (paru)
 alias unlock="sudo rm /var/lib/pacman/db.lck" # remove pacman lock
 alias cleanup="pacman -Qtdq | pacman -Rns -" # remove orphaned packages

# System
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"
alias po="systemctl poweroff"

#add new fonts
alias update-fc="sudo fc-cache -fv"

#Recent Installed Packages
#alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias rip="expac --timefmt='%d-%m-%Y %T' '%l\t%n %v'"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Functions
# ex = Extractor for all kinds of archives
ex ()
{
	(mkdir /tmp/$1)
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1  ;;
      *.tar.gz)    tar xzf $1  ;;
      *.bz2)       bunzip2 $1  ;;
      *.rar)       unrar x $1  ;;
      *.gz)        gunzip $1   ;;
      *.tar)       tar xf $1   ;;
      *.tbz2)      tar xjf $1  ;;
      *.tgz)       tar xzf $1  ;;
      *.zip)       unzip $1    ;;
      *.Z)         uncompress $1 ;;
      *.7z)        7z x $1 ;;
      *.deb)       ar x $1 ;;
      *.tar.xz)    tar xf $1 -C /tmp/$1 ;;
      *.tar.zst)   tar xf $1 ;;
      *)           echo ""$1" cannot be extracted via ex()" ;;
     esac
   else
     echo ""$1" is not a valid file"
   fi
 }


#  Fzf
#export FZF_DEFAULT_COMMAND="fd -H -E '.git' --type f"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"

# Fzf and cd dir
f() {
  local dir
  dir=$(fd ${1} -H -E .git | fzf)
  if [[ -d "$dir" ]] ; then
      cd "$dir"
    elif [[ -n "$dir" ]] ; then
      "$EDITOR" "$dir"
  fi
}

fa() {
  local dir
  dir=$(fd . / -H | fzf)
  if [[ -d "$dir" ]] ; then
      cd "$dir"
  else
      cd $(dirname "$dir")
  fi
}

fo() {
  IFS=$"\n" out=("$(fzf-tmux --query="$1" --exit-0)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
      ${EDITOR:-vim} "$file"
  fi
}

eval "$(starship init zsh)"
