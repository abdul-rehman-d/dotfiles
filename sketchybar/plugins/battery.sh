#!/bin/sh

PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

NORMAL_ICON_COLOR="0xffFF79C6"
NORMAL_LABEL_COLOR="0xfff8fbf2"
LOW_BATT_COLOR="0xffff0000"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON=""
  ;;
  [6-8][0-9]) ICON=""
  ;;
  [3-5][0-9]) ICON=""
  ;;
  [1-2][0-9]) ICON=""
  ;;
  *) ICON=""
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

ICON_COLOR="$NORMAL_ICON_COLOR"
LABEL_COLOR="$NORMAL_LABEL_COLOR"

if [[ "$CHARGING" = "" ]] && [ "$PERCENTAGE" -lt 10 ]; then
  if [ $(( $(date +%s) % 2 )) -eq 0 ]; then
    ICON_COLOR="$LOW_BATT_COLOR"
    LABEL_COLOR="$LOW_BATT_COLOR"
  fi
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" icon.color="$ICON_COLOR" label.color="$LABEL_COLOR"
