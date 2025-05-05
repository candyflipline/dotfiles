#!/bin/bash

sketchybar --add item cpu right \
           --set cpu  update_freq=2 \
                      icon=􀧓  \
                      script="$PLUGIN_DIR/cpu.sh" \
                      background.color=$BAR_COLOR \
                      icon.color=$ACCENT_COLOR \
                      label.color=$WHITE
