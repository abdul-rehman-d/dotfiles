#!/usr/bin/env bash

WORKSPACE="$1"

if [ -z "$FOCUSED_WORKSPACE" ]; then
  FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)
fi

if [ "$SENDER" = "aerospace_workspace_change" ] && [ "$WORKSPACE" = "misc:1" ]; then
  misc_visibility=()
  for misc_workspace in misc:1 misc:2 misc:3; do
    if [ "$misc_workspace" = "$FOCUSED_WORKSPACE" ] || aerospace list-windows --workspace "$misc_workspace" --format "%{app-name}" | grep -q .; then
      misc_visibility+=(--set "space.$misc_workspace" drawing=on)
    else
      misc_visibility+=(--set "space.$misc_workspace" drawing=off)
    fi
  done
  sketchybar "${misc_visibility[@]}"
fi

case "$WORKSPACE" in
  misc:*)
    if [ "$SENDER" != "aerospace_workspace_change" ]; then
      if [ "$WORKSPACE" != "$FOCUSED_WORKSPACE" ] && ! aerospace list-windows --workspace "$WORKSPACE" --format "%{app-name}" | grep -q .; then
        sketchybar --set "$NAME" drawing=off
        exit 0
      fi
      sketchybar --set "$NAME" drawing=on
    fi
    ;;
  *)
    sketchybar --set "$NAME" drawing=on
    ;;
esac

if [ "$SENDER" = "mouse.entered" ]; then
  if [ "$WORKSPACE" != "$FOCUSED_WORKSPACE" ]; then
    APPS=$(aerospace list-windows --workspace "$WORKSPACE" --format "%{app-name}" | awk 'NF && !seen[$0]++ { if (out) out=out ", " $0; else out=$0 } END { print out }')

    if [ -z "$APPS" ]; then
      APPS="No windows"
    fi

    sketchybar --set front_app label="$APPS"
  fi
fi

if [ "$SENDER" = "mouse.exited" ]; then
  CURRENT_APP=$(aerospace list-windows --focused --format "%{app-name}" 2>/dev/null)
  if [ -z "$CURRENT_APP" ]; then
    CURRENT_APP="No windows"
  fi
  sketchybar --set front_app label="$CURRENT_APP"
fi

if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=0xffBD93F9 \
    icon.color=0xff282a36
else
  sketchybar --set "$NAME" \
    background.drawing=on \
    background.color=0x40ffffff \
    icon.color=0xfff8fbf2
fi
