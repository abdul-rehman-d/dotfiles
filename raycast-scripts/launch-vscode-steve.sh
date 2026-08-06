#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Launch VS Code - Steve
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💼
# @raycast.packageName VS Code
# @raycast.argument1 { "type": "text", "placeholder": "location", "optional": true }

location="$1"

args=(
  --user-data-dir="$HOME/vscode-steve/user-data"
  --extensions-dir="$HOME/vscode-steve/extensions"
  --remote tunnel+wf19806
)

if [[ -n "$location" ]]; then
  args+=("$location")
fi

open -n "/Applications/Visual Studio Code.app" --args "${args[@]}"
