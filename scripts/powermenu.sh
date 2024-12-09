#!/usr/bin/env bash

rofi_command="rofi -dmenu -select-row 0 -theme powermenu.rasi"

# Options
#lock="Lock"
#logout="Logout"
reboot="Reboot"
shutdown="Shutdown"
#suspend="Suspend"

# Variable passed to rofi
#options="$lock\n$logout\n$reboot\n$shutdown\n$suspend"
options="$reboot\n$shutdown"

chosen="$(echo -e "$options" | $rofi_command)"
case $chosen in
    $shutdown)
    systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock ]]; then
			i3lock
		elif [[ -f /usr/bin/betterlockscreen ]]; then
			betterlockscreen -l
		fi
        ;;
    $suspend)
		systemctl suspend
        ;;
    $logout)
        loginctl kill-session $XDG_SESSION_ID
        ;;
esac
