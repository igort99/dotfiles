#!/bin/bash

# Get the number of the highest workspace
CURRENT_WS=$(i3-msg -t get_workspaces | jq -r '.[].num' | sort -n | tail -1)
NEW_WS=$((CURRENT_WS + 1))

# Move to the new workspace on the current monitor
i3-msg workspace number $NEW_WS
