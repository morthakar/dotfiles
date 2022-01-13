from libqtile.config import Click, Drag, Key
from libqtile.command import lazy


def init_keys(mod="mod4", terminal="alacritty"):
    return [
        # Switch between windows
        Key([mod], "Left", lazy.layout.left(), desc="Move focus to left"),
        Key([mod], "Right", lazy.layout.right(), desc="Move focus to right"),
        Key([mod], "Down", lazy.layout.down(), desc="Move focus down"),
        Key([mod], "Up", lazy.layout.up(), desc="Move focus up"),
        Key(
            [mod], "space", lazy.layout.next(), desc="Move window focus to other window"
        ),
        # Move windows between left/right columns or move up/down in current stack.
        # Moving out of range in Columns layout will create new column.
        Key(
            [mod, "shift"],
            "Left",
            lazy.layout.shuffle_left(),
            desc="Move window to the left",
        ),
        Key(
            [mod, "shift"],
            "Right",
            lazy.layout.shuffle_right(),
            desc="Move window to the right",
        ),
        Key(
            [mod, "shift"], "Down", lazy.layout.shuffle_down(), desc="Move window down"
        ),
        Key([mod, "shift"], "Up", lazy.layout.shuffle_up(), desc="Move window up"),
        # Grow windows. If current window is on the edge of screen and direction
        # will be to screen edge - window would shrink.
        Key([mod], "KP_Add", lazy.layout.grow()),
        Key([mod], "KP_Subtract", lazy.layout.shrink()),
        Key([mod], "n", lazy.layout.normalize()),
        Key([mod], "m", lazy.layout.maximize()),
        # Toggle between split and unsplit sides of stack.
        # Split = all windows displayed
        # Unsplit = 1 window displayed, like Max layout, but still with
        # multiple stack panes
        Key(
            [mod, "shift"],
            "Return",
            lazy.layout.toggle_split(),
            desc="Toggle between split and unsplit sides of stack",
        ),
        Key([mod], "b", lazy.spawn("brave"), desc="Launch brave"),
        Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
        Key([mod], "p", lazy.spawn("dmenu_run"), desc="Launch dmenu"),
        # Toggle between different layouts as defined below
        Key([mod], "Tab", lazy.next_screen()),
        Key([mod], "f", lazy.window.toggle_fullscreen()),
        Key([mod, "shift"], "f", lazy.window.toggle_floating()),
        Key([mod], "F2", lazy.next_layout(), desc="Toggle between layouts"),
        Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
        Key([mod, "control"], "r", lazy.restart()),
    ]


def simple_key_binder(mod, keynames=None):
    # Bind keys to mod+group position or to the keys specified as second argument
    def func(dgroup):
        # unbind all
        for key in dgroup.keys[:]:
            dgroup.qtile.ungrab_key(key)
            dgroup.keys.remove(key)

        if keynames:
            keys = keynames
        else:
            # keys 1 to 9 and 0
            keys = list(map(str, list(range(1, 10)) + [0]))

        # bind all keys
        for keyname, group in zip(keys, dgroup.qtile.groups):
            name = group.name
            # Switch to Group
            key = Key([mod], keyname, lazy.group[name].toscreen())
            dgroup.keys.append(key)
            dgroup.qtile.grab_key(key)

            # Send active window to another Group and Follow
            key_sf = Key(
                [mod, "shift"],
                keyname,
                lazy.window.togroup(name),
                lazy.group[name].toscreen(),
            )
            dgroup.keys.append(key_sf)
            dgroup.qtile.grab_key(key_sf)

            # Send window to screen 2
            key_c = Key(
                [mod, "control"],
                keyname,
                lazy.window.togroup(name),
                lazy.group[name].toscreen(1),
            )
            dgroup.keys.append(key_c)
            dgroup.qtile.grab_key(key_c)

    return func
