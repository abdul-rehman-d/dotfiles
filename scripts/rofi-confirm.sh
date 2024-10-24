#!/bin/bash

choice=`echo -e "yes\nno" | rofi -dmenu -p "Are you sure you want to $1?"`

if [[ $choice = "yes" ]]; then
  $2
else
  exit 0
fi

