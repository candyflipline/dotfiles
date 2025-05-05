#!/usr/bin/env bash

QUOTE="What would you do if you had x100 agency?"

sketchybar --add item quote center \
           --set quote label="$QUOTE" \
           label.color=$WHITE \
           label.font="SF Pro:Bold:15.0" \
           background.color=$BAR_COLOR \
           icon.color=$ACCENT_COLOR \
           icon="􁈏"

