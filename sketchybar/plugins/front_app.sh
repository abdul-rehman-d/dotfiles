#!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

if [ "$SENDER" = "front_app_switched" ]; then
  sketchybar --set "$NAME" label="$INFO"
fi

if [ "$SENDER" = "aerospace_workspace_change" ]; then
  # this should be empty if the workspace is empty
  if [ -z $(aerospace list-windows --workspace $FOCUSED_WORKSPACE) ]; then
    sketchybar --set "$NAME" label="No windows"
  fi
fi
