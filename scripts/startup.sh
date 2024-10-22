#!/bin/bash

function setup_workflow {
  xdotool key super+1
  google-chrome "https://outlook.office.com/mail/" &
  sleep 4

  xdotool key super+2
  tmux new-session -s ccc -c ~/dev/work/ccc-registry-current -d
  tmux rename-window 'nvim'
  tmux new-window -c ~/dev/work/ccc-registry-current
  tmux split-window -v -c ~/dev/work/ccc-registry-current
  kitty --hold tmux attach &
  sleep 1
  
  xdotool key super+3
  google-chrome --new-window "https://teams.microsoft.com/v2/" &
  sleep 2

  xdotool key super+4
  nemo &
  sleep 1

  xdotool key super+5
  code
  sleep 2

  xdotool key super+7
  firefox -P Personal --new-instance &
  sleep 2

  xdotool key super+2
}

declare -a options=(
"yes"
"no"
)

choice=$(printf '%s\n' "${options[@]}" | rofi -dmenu -p "Do you wanna setup the workflow?")

if [[ $choice == 'yes' ]]; then
  setup_workflow
elif [[ $choice == 'no' ]]; then
  exit 0
else
  echo "Program terminated" && exit 1
fi

