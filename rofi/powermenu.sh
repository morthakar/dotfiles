#!/usr/bin/env bash

THEME="$POLYBARTHEME/powermenu.rasi"
rofi_command="rofi -no-config -theme $THEME"

uptime=$(uptime -p | sed -e 's/up //g')

# Options
lock="Lock"
logout="Logout"
reboot="Restart"
shutdown="Shutdown"
suspend="Suspend"

# Variable passed to rofi
options="$lock\n$logout\n$reboot\n$shutdown\n$suspend"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 0)"
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
