#!/bin/bash

sketchybar --add item calendar right \
           --set calendar icon=􀧞  \
                          update_freq=30 \
                          script="$PLUGIN_DIR/calendar.sh" \
                          background.color=$BAR_COLOR \
                          icon.color=$ACCENT_COLOR \
                          label.color=$WHITE
