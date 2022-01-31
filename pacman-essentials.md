# Write iso to USB
sudo dd bs=4M if=/path/to/arcolinux...iso of=/dev/sdX status=progress && sync

# List
Installed Packages: pacman -Qe
Installed Native Packages: pacman -Qent
Installed Packages with preview: pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'
Installed AUR packages: pacman -Qqm
Installed Foreign packages: pacman -Qm
Installed Native Packages: pacman -Qn
Listing files owned by a package with sizes: pacman -Qlq package | grep -v '/$' | xargs -r du -h | sort -h
All Packages : pacman -Slq | fzf --preview 'pacman -Si {}' --layout=reverse

# Search
Packages by Group: pacman -Sg group
Packages by Regex: pacman -Qs regex
Installed Packages with sizes: LC_ALL=C pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}' | sort -h
Installed Packages not in the base meta packages: comm -23 <(pacman -Qqe | sort) <(expac -l '\n' '%E' base | sort)
Installed Packages not in the base meta package or base-devel package group: comm -23 <(pacman -Qqe | sort) <({ pacman -Qqg base-devel; expac -l '\n' '%E' base; } | sort -u)
Installed Packages unrequired by other packages, and which are not in the base meta package or base-devel package group: comm -23 <(pacman -Qqt | sort) <({ pacman -Qqg base-devel; expac -l '\n' '%E' base; } | sort -u)
Installed Packages that are not in the specified repository repo_name: comm -23 <(pacman -Qq | sort) <(pacman -Sql repo_name | sort)
Installed Packages that are in the repo_name repository: comm -12 <(pacman -Qq | sort) <(pacman -Sql repo_name | sort)

Development/Unstable Packages: pacman -Qq | grep -Ee '-(bzr|cvs|darcs|git|hg|svn)$'


Identify files not owned by any packages: find /etc /usr /opt | LC_ALL=C pacman -Qqo - 2>&1 >&- >/dev/null | cut -d ' ' -f 5-

List installed packages: pacman -Qqe || pacman -Qqe > pkglist.txt

Getting the dependencies list of several packages: LC_ALL=C pacman -Si packages | awk -F'[:<=>]' '/^Depends/ {print $2}' | xargs -n1 | sort -u

# Install
Install packages from a list: pacman -S --needed - < pkglist.txt
Install packages form a list, removing foregin packages: pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort pkglist.txt))
Reinsall all packages: pacman -Qqn | pacman -S -
Removing unused packages (orphans): pacman -Qtdq | pacman -Rns -


