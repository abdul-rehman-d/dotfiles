#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Launch VS Code - Steve
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💼
# @raycast.packageName VS Code

open -n "/Applications/Visual Studio Code.app" --args \
  --user-data-dir="$HOME/vscode-steve/user-data" \
  --extensions-dir="$HOME/vscode-steve/extensions"
