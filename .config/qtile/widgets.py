import os
import socket
from libqtile import qtile
from libqtile import widget, bar

terminal = "alacrity"

colors = dict(
    panel_background=["#322834", "#322834"],
    current_screen_background=["#3d3f4b", "#434758"],
    group_active=["#ffffff", "#ffffff"],
    current_tab_border=["#ff5555", "#ff5555"],
    other_tab_border=["#74438f", "#74438f"],
    even_widgets=["#4f76c7", "#4f76c7"],
    window_name=["#e1acff", "#e1acff"],
    group_inative=["#ecbbfb", "#ecbbfb"],
)


##### DEFAULT WIDGET SETTINGS #####
widget_defaults = dict(
    font="Symbols Nerd",
    fontsize=12,
    padding=2,
    foreground=colors["group_active"],
    background=colors["panel_background"],
)
extension_defaults = widget_defaults.copy()


def init_widgets():
    return [
        widget.GroupBox(
            # Colors
            # active="#1100ff",  # Tem janela
            # block_highlight_text_color="#1100ff",  # Selecionado Texto
            # highlight_color=["#1100ff", "#1100ff"],  # Selecionado
            this_current_screen_border=[
                "#f52500",
                "#f50000",
            ],  # Selecionado Linha Focado
            # this_screen_border="#00e1ff",  # Selecionado Linha Sem Foco
            background=["#141414", "#000000"],
            foreground="#0014c7",
            inactive="#bfbbbb",
            # other_current_screen_border="#e76f51",
            # other_screen_border="fcfcfc",
            #######################################
            borderwidth=2,
            center_aligned=True,
            disable_drag=False,
            fmt="{}",
            font="Symbols Nerd Font",
            # fontshadow="",
            fontsize=16,
            hide_unused=False,
            highlight_method="text",
            invert_mouse_wheel=False,
            margin_x=4,
            margin_y=3,
            rounded=True,
            spacing=10,
            use_mouse_wheel=True,
        ),
        widget.WindowName(
            fontsize=12,
            foreground=[
                "#f52500",
                "#f50000",
            ],
            background=["#141414", "#000000"],
        ),
        widget.CheckUpdates(
            foreground=[
                "#f52500",
                "#f50000",
            ],
            background=["#141414", "#000000"],
            no_update_string="?",
        ),
        widget.Memory(
            font="Symbols Nerd Font",
            fontsize=12,
            foreground=[
                "#f52500",
                "#f50000",
            ],
            background=["#141414", "#000000"],
            format="{MemUsed: .2f}{mm} /{MemTotal: .0f}{mm}",
            measure_mem="G",
            padding=10,
        ),
        widget.CPU(
            foreground=[
                "#f52500",
                "#f50000",
            ],
            format="CPU {load_percent}%",
            background=["#141414", "#000000"],
        ),
        widget.Clock(
            font="Symbols Nerd Font",
            fontsize=12,
            foreground=[
                "#f52500",
                "#f50000",
            ],
            background=["#141414", "#000000"],
            format=" %A, %d/%m/%Y  %H:%M ",
            padding=10,
        ),
        widget.Systray(
            foreground=[
                "#f52500",
                "#f50000",
            ],
            background=["#141414", "#000000"],
        ),
    ]
