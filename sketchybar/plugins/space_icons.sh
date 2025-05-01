#!/usr/bin/env bash
# space_icons.sh
# Triggered by: aerospace events (space/window changes) and front_app_switched

# point this at your icon‐mapping helper
ICON_FN="$CONFIG_DIR/plugins/icon_map_fn.sh"

# 1) grab the full JSON list of workspaces
ws_json="$(aerospace list-workspaces --json)"

# 2) iterate each workspace object
echo "$ws_json"  \
  | jq -c '.[]' \
  | while read -r ws; do
      # extract the workspace index/id
      idx=$(jq -r '.index' <<<"$ws")
      # get the app‐bundle‐IDs (keys) in this space
      apps=( $(jq -r '.apps | keys[]?' <<<"$ws") )
      
      # build the icon strip
      if [ "${#apps[@]}" -gt 0 ]; then
        strip=""
        for bundle in "${apps[@]}"; do
          # map bundle → icon
          icon="$("$ICON_FN" "$bundle")"
          strip+=" $icon"
        done
      else
        strip=" -"   # fallback for empty space
      fi

      # 3) push to SketchyBar
      sketchybar --set space.$idx label="$strip"
    done