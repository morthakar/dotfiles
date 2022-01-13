from libqtile.config import Screen
from libqtile import bar


def init_screens(widget):
    return [
        Screen(top=bar.Bar(widgets=widget, opacity=1.0, size=20)),
        Screen(top=bar.Bar(widgets=widget, opacity=1.0, size=20)),
    ]