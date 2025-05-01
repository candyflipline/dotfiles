#!/bin/bash

CPU_PERCENTAGE=$(top -l 1 | grep -E "^CPU usage" | awk '{print $3 + $5}')

# Format to integer
CPU_PERCENT=$(printf "%.0f" "$CPU_PERCENTAGE")

sketchybar --set $NAME label="$CPU_PERCENT%"