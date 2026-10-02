#!/bin/sh

STATE_FILE="${TMPDIR:-/tmp}/sketchybar_timer_$(id -u)"

if [ "${1:-}" = "toggle" ]; then
  if [ -f "$STATE_FILE" ]; then
    rm -f "$STATE_FILE"
  else
    date +%s > "$STATE_FILE"
  fi
fi

if [ -f "$STATE_FILE" ]; then
  STARTED_AT="$(cat "$STATE_FILE")"
  NOW="$(date +%s)"

  case "$STARTED_AT" in
    ''|*[!0-9]*)
      rm -f "$STATE_FILE"
      sketchybar --set "$NAME" icon="▶" icon.color="0xff50FA7B" label="START"
      exit 0
      ;;
  esac

  ELAPSED=$((NOW - STARTED_AT))
  MINUTES=$((ELAPSED / 60))
  SECONDS=$((ELAPSED % 60))
  LABEL="$(printf '%02d:%02d' "$MINUTES" "$SECONDS")"

  if [ $((NOW % 2)) -eq 0 ]; then
    ICON_COLOR="0xffFF5555"
  else
    ICON_COLOR="0x00FF5555"
  fi

  sketchybar --set "$NAME" icon="⏹" icon.color="$ICON_COLOR" label="$LABEL"
else
  sketchybar --set "$NAME" icon="▶" icon.color="0xff50FA7B" label="START"
fi
