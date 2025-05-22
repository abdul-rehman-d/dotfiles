#!/usr/bin/env bash

is_active=false
is_empty=true

FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    is_active=true
fi

if [ `aerospace list-windows --workspace $1 | wc -l` != "0" ]; then
    is_empty=false
fi

sketchybar --set $NAME \
    background.drawing=$([[ "$is_active" == true ]] && echo "on" || echo "off") \
    icon.color=$([[ "$is_empty" == true ]] && echo "0x40f8fbf2" || echo "0xfff8fbf2")

