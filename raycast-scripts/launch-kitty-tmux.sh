#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Tmux in Kitty
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🐱
# @raycast.packageName Terminal


if pgrep tmux > /dev/null; then
  open -n "/Applications/kitty.app" --args \
    --hold tmux attach;
else
  open -n "/Applications/kitty.app" --args \
    --hold tmux new-session -s "poop" -c "$HOME/dev/personal/poop"
fi

