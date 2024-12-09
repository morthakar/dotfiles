```json
{
  "System": {
    "Audio": "pulseaudio",
    "AutoMount": "udiskie",
    "Autostart": "xorg-xinit",
    "Clipboard": "xclip",
    "Compositor": "picom",
    "DisplayServer": "xorg",
    "Driver": "nvidia-dkms",
    "Enviroment": {
      "Apps": [
        "brave",
        "calibre",
        "discord",
        "firefox"
      ],
      "CommandLine": [
        "bat",
        "eza",
        "fd",
        "fzf",
        "git",
        "nordvpn",
        "ripgrep"
      ],
      "Editor": "neovim",
      "FileManagemer": "pcmanfm",
      "Launcher": "rofi",
      "Notification": "dunst",
      "PackageManager": [
        "yay",
        "paru"
      ],
      "Fonts": [
        "ttf-firacode-nerd",
        "ttf-ms-win11-auto"
      ],
      "Prompt": "starship",
      "SessionMultiplexer": "tmux",
      "Shell": "fish",
      "StatusBar": "polybar",
      "Terminal": "alacritty",
      "WallpaperManager": "feh",
      "WindowManager": "leftwm",
      "Network": "networkmanager",
      "Numlock": "numloclx",
      "Screen": "xorg-xrandr"
    }
  }
}
```
```bash
# Login shell initialization e.g .bash_profile
if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
	exec startx --vt1 &> /dev/null
fi
```

```bash
# .xinitrc
xrandr --output HDMI-0 --primary --mode 1920x1080 --output DP-0 --mode 1600x900 --right-of HDMI-0
numlockx &
exec leftwm
```

```bash
# Sets default login shell
chsh -s /bin/fish
```

```bash
# /etc/systemd/system/getty@tty1.service.d/autologin.conf
[Service]
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin username %I $TERM
```





