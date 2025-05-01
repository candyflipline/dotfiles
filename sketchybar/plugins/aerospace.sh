#!/usr/bin/env bash

source "$CONFIG_DIR/colors.sh"

stripped_name=${NAME#space.}

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on \
                         background.color=$ACCENT_COLOR \
                         label.color=$BAR_COLOR \
                         icon.color=$BAR_COLOR
else
    sketchybar --set $NAME background.drawing=off \
                         label.color=$ACCENT_COLOR \
                         icon.color=$ACCENT_COLOR
fi

APPS_JSON=$(aerospace list-windows --workspace "$stripped_name" --json)
if [ "$APPS_JSON" != "[]" ]; then
    APP_NAMES=$(echo "$APPS_JSON" | jq -r '.[].["app-name"]')
    icon_strip="$stripped_name |"
    while read -r app
    do
        icon_strip+=" $($CONFIG_DIR/plugins/icon_map_fn.sh "$app")"
    done <<< "$APP_NAMES"
else
    icon_strip="$stripped_name —"
fi

sketchybar --set $NAME label="$icon_strip"