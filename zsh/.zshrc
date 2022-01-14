# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration
export PATH=$PATH:/usr/local/go/bin

# You may need to manually set your language environment
export LANG=pt_BR.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# dev
alias dev='cd ~/dev'
alias devgo='cd ~/dev/Go'
alias devpy='cd ~/dev/Python'
alias devrs='cd ~/dev/Rust'
alias devsh='cd ~/dev/ShellScript'
alias books='cd ~/Books'
alias vim=nvim

# Edit Configs
alias cfg='cd ~/.config'
alias fishe='nvim ~/.config/fish/config.fish'
alias zshe='nvim ~/.zshrc'
alias nvime='nvim ~/.config/nvim/init.vim'
alias stare='nvim ~/.config/starship.toml'

# Changing "ls" to "lsd"
alias ls='lsa'
alias lsa='lsd -alh --group-dirs first'

 # pacman and yay
 alias pacman='sudo pacman' # update only standard pkgs
 alias pacsyu='sudo pacman -Syyu' # update only standard pkgs
 alias yaysua='yay -Sua --noconfirm' # update only AUR pkgs (yay)
 alias yaysyu='yay -Syu --noconfirm' # update standard pkgs and AUR pkgs (yay)
 alias parsua='paru -Sua --noconfirm' # update only AUR pkgs (paru)
 alias parsyu='paru -Syu --noconfirm' # update standard pkgs and AUR pkgs (paru)
 alias unlock='sudo rm /var/lib/pacman/db.lck' # remove pacman lock
 alias cleanup='pacman -Qtdq | pacman -Rns -' # remove orphaned packages

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

#add new fonts
alias update-fc='sudo fc-cache -fv'

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

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
      *)           echo "'$1' cannot be extracted via ex()" ;;
     esac
   else
     echo "'$1' is not a valid file"
   fi
 }


# Modified version where you can press
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# Fzf and cd dir
f() {
  local dir
  dir=$(fd ${1} -H | fzf +m)
  if [[ -d "$dir" ]] ; then
      cd "$dir"
  else
      cd $(dirname "$dir")
  fi
}

fa() {
  local dir
  dir=$(fd ${1} -H . /  | fzf +m)
  if [[ -d "$dir" ]] ; then
      cd "$dir"
  else
      cd $(dirname "$dir")
  fi
}

fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
      ${EDITOR:-vim} "$file"
  fi
}

eval "$(starship init zsh)"
