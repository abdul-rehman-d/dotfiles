#!/usr/bin/env bash

# is_active=false
# is_empty=true
#
# FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
#
# if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
#     is_active=true
# fi
#
# if [ `aerospace list-windows --workspace $1 | wc -l` != "0" ]; then
#     is_empty=false
# fi


# if no focused_workspace is set, set it using command `aerospace list-workspaces --focused`
if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

sketchybar --set $NAME label=$FOCUSED_WORKSPACE

