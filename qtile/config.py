import os
import subprocess
import re
from pathlib import Path

from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile import hook

mod = "mod4"
terminal = "kitty"
home = os.path.expanduser("~")


def addOpacityToHexColors(color: str, opacity: float = 1.0) -> str:
    if len(color) != 7 or not color.startswith("#"):
        return color
    alpha = int(opacity * 255)
    return color + f"{alpha:02X}"


colors = {
    "bg": "#282A36",
    "current": "#44475A",
    "fg": "#F8F8F2",
    "comment": "#6272A4",
    "cyan": "#8BE9FD",
    "green": "#50FA7B",
    "orange": "#FFB86C",
    "pink": "#FF79C6",
    "purple": "#BD93F9",
    "red": "#FF5555",
    "yellow": "#F1FA8C",
}

tranparentishBG = addOpacityToHexColors(colors["bg"], 0.8)
transparent = "#00000000"

sticky_windows = []


@lazy.function
def toggle_sticky_windows(qtile, window=None):
    if window is None:
        window = qtile.current_screen.group.current_window
    if window in sticky_windows:
        sticky_windows.remove(window)
    else:
        sticky_windows.append(window)
    return window


@hook.subscribe.startup_once
def autostart():
    script = os.path.expanduser("~/dotfiles/scripts/autostart.sh")
    subprocess.run([script])


@hook.subscribe.client_focus
def set_hint(window):
    window.window.set_property(
        "IS_FLOATING", str(window.floating), type="STRING", format=8
    )


@hook.subscribe.setgroup
def move_sticky_windows():
    for window in sticky_windows:
        window.togroup()
    return


@hook.subscribe.client_killed
def remove_sticky_windows(window):
    if window in sticky_windows:
        sticky_windows.remove(window)


keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "left", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "right", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "down", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "up", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key(
        [mod, "shift"],
        "left",
        lazy.layout.shuffle_left(),
        desc="Move window to the left",
    ),
    Key(
        [mod, "shift"],
        "right",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "down", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "up", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key(
        [mod, "control"],
        "left",
        lazy.layout.grow_left(),
        desc="Grow window to the left",
    ),
    Key(
        [mod, "control"],
        "right",
        lazy.layout.grow_right(),
        desc="Grow window to the right",
    ),
    Key([mod, "control"], "down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key(
    #     [mod, "shift"],
    #     "Return",
    #     lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack",
    # ),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "q", lazy.window.kill(), desc="Kill focused window"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key(
        [mod],
        "t",
        lazy.window.toggle_floating(),
        desc="Toggle floating on the focused window",
    ),
    # Qtile things
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    # Launcher / Scripts
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "d", lazy.spawn("rofi -modi drun,run -show drun"), desc="Spawn rofi"),
    Key([mod], "v", lazy.spawn("copyq menu"), desc="Spawn copyq"),
    Key([mod, "shift"], "Escape", lazy.spawn("systemctl suspend"), desc="suspend"),
    Key(
        [mod, "shift"],
        "Return",
        lazy.spawn(home + "/dotfiles/scripts/tmux-sessionizer"),
        desc="tmux sessionizer",
    ),
    Key([], "Print", lazy.spawn("flameshot gui"), desc="suspend"),
    Key(
        [mod, "shift"],
        "e",
        lazy.spawn(
            home
            + "/dotfiles/scripts/rofi-confirm.sh 'logout' 'qtile cmd-obj -o root -f shutdown'"
        ),
        desc="Shutdown Qtile",
    ),
    Key(
        [mod, "shift"],
        "x",
        lazy.spawn(
            home + "/dotfiles/scripts/rofi-confirm.sh 'shutdown' 'shutdown now'"
        ),
        desc="Shutdown",
    ),
    # Special keys
    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn(home + "/dotfiles/scripts/change_brightness up"),
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn(home + "/dotfiles/scripts/change_brightness down"),
    ),
    Key(
        [],
        "XF86AudioRaiseVolume",
        lazy.spawn(home + "/dotfiles/scripts/change_volume up"),
    ),
    Key(
        [],
        "XF86AudioLowerVolume",
        lazy.spawn(home + "/dotfiles/scripts/change_volume down"),
    ),
    Key(
        [],
        "XF86AudioMute",
        lazy.spawn(home + "/dotfiles/scripts/change_volume mute"),
    ),
    Key(
        [],
        "XF86AudioMicMute",
        lazy.spawn(home + "/dotfiles/scripts/change_volume mute-mic"),
    ),
    Key(
        [mod],
        "s",
        toggle_sticky_windows(),
        desc="Toggle state of sticky for current window",
    ),
]


groups = [
    Group(i)
    for i in [
        "www",
        "dev",
        "chat",
        "code",
        "files",
        "p-www",
        "wa",
        "music",
        "misc",
    ]
]

for i, group in enumerate(groups):
    key = str(i + 1)
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                key,
                lazy.group[group.name].toscreen(),
                desc=f"Switch to group {group.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                key,
                lazy.window.togroup(group.name, switch_group=True),
                desc=f"Switch to & move focused window to group {group.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(
        border_focus=colors["purple"],
        border_focus_stack=["#d75f5f", "#8f3d3d"],
        border_width=1,
        border_on_single=True,
        margin=2,
        margin_on_single=10,
    ),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="mono",
    fontsize=14,
    padding=2,
    background=tranparentishBG,
)
extension_defaults = widget_defaults.copy()

spacer = widget.Spacer(
    length=10,
    background=tranparentishBG,
)
sep = widget.Sep(
    linewidth=2,
    padding=8,
    background=tranparentishBG,
    foreground=colors["purple"],
    rounded=True,
)


def get_only_win_name(name: str) -> str:
    match = re.search(r"[^\w\s](?!.*[^\w\s])", name)
    if match is None:
        return name
    if match.start() < 0:
        return name
    return name[match.start() + 1 :].strip()


widgets = [
    widget.Chord(
        chords_colors={
            "launch": ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ),
    sep,
    widget.GroupBox(
        highlight_method="line",
        inactive=addOpacityToHexColors(colors["fg"], 0.5),
        highlight_color=transparent,
        this_current_screen_border=colors["purple"],
    ),
    sep,
    widget.Prompt(),
    widget.WindowName(
        format="{name}",
        parse_text=get_only_win_name,
        foreground=colors["comment"],
    ),
    spacer,
    widget.CurrentLayoutIcon(
        scale=0.65,
        fmt="Layout: {}",
        background=colors["current"],
        padding=10,
    ),
    spacer,
    widget.Clock(
        format="%a %Y-%m-%d %I:%M %p",
        background=colors["cyan"],
        foreground=colors["bg"],
    ),
    spacer,
    widget.Memory(
        background=colors["green"],
        foreground=colors["bg"],
        measure_mem="G",
        fmt="MEM: {}",
        format="{MemUsed:.2f}{mm}/{MemTotal:.2f}{mm}",
    ),
    spacer,
    widget.CPU(
        background=colors["orange"],
        foreground=colors["bg"],
        fmt="CPU: {}",
        format="{freq_current}GHz {load_percent}%",
    ),
    spacer,
    widget.Volume(
        background=colors["pink"],
        foreground=colors["bg"],
        fmt="VOL: {}",
        mute_foreground=colors["comment"],
        unmute_format="{volume}%",
        mute_format="M {volume}%",
        get_volume_command=home + "/dotfiles/scripts/get_volume",
        check_mute_command=home + "/dotfiles/scripts/get_muted",
        check_mute_string="muted",
    ),
    spacer,
]
if any(Path("/sys/class/power_supply/").iterdir()):
    widgets.extend(
        [
            widget.Battery(
                format="BAT: {char}{percent:2.0%}",
                discharge_char="",
                charge_char="^ ",
                empty_char="x ",
                background=colors["yellow"],
                foreground=colors["bg"],
            ),
            spacer,
        ]
    )

widgets.append(
    widget.Systray(
        background=colors["bg"],
    )
)

screens = [
    Screen(
        top=bar.Bar(
            widgets,
            26,
            background=transparent,
            foreground=colors["fg"],
            margin=2,
            padding=3,
            border_width=[5, 0, 5, 0],
            border_color=tranparentishBG,
        ),
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        # Match(title="CopyQ"),  # CopyQ
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
