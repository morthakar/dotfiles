# -*- coding: utf-8 -*-
import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen
from libqtile.command import lazy
from libqtile import layout, bar, widget, hook
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from typing import List  # noqa: F401from typing import List  # noqa: F401
from keys import init_keys, simple_key_binder
from groups import init_groups
from layouts import init_layouts, init_floating_layout
from widgets import init_widgets

mod = "mod4"  # Sets mod key to SUPER/WINDOWS
terminal = "alacritty"  # My terminal of choice


keys = init_keys(mod, terminal)
groups = init_groups()
dgroups_key_binder = simple_key_binder(mod)
layouts = init_layouts()
floating_layout = init_floating_layout()


def init_screens():
    return [
        Screen(top=bar.Bar(widgets=init_widgets(), opacity=0.8, size=25)),
        Screen(top=bar.Bar(widgets=init_widgets(), opacity=0.8, size=25)),
    ]


if __name__ in ["config", "__main__"]:
    screens = init_screens()


dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = False
auto_minimize = True

mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod],
        "Button3",
        lazy.window.set_size_floating(),
        start=lazy.window.get_size(),
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]


@hook.subscribe.startup_once
def start_once():
    home = os.path.expanduser("~")
    subprocess.call([home + "/.config/qtile/autostart.sh"])


# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
