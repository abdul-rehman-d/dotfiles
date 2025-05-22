#!/bin/bash

DISK_PERCENT=$(df -lh | grep /dev/disk1s2 | awk '{ printf ("%02.0f\n", $5) }')

sketchybar --set $NAME label="$DISK_PERCENT%"
