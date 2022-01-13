#!/usr/bin/env bash 

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output HDMI-0 --auto --output DP-0 --auto --right-of HDMI-0 

#festival --tts $HOME/.config/qtile/welcome_msg &
#birdtray &
lxsession &
picom &
#conky -c $HOME/.config/conky/doomone-qtile.conkyrc
volumeicon &
#nm-applet &
nitrogen --restore &

