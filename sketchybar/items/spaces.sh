# #!/bin/bash

# sketchybar --add event aerospace_workspace_change

# for sid in $(aerospace list-workspaces --monitor all --empty no); do
#     sketchybar --add item space.$sid left \
#         --subscribe space.$sid aerospace_workspace_change \
#         --set space.$sid \
#         background.color=$ITEM_BG_COLOR \
#         label="$sid" \
#         label.font="sketchybar-app-font:Regular:16.0" \
#         label.padding_right=10 \
#         label.y_offset=-1 \
#         click_script="aerospace workspace $sid" \
#         script="$CONFIG_DIR/plugins/aerospace.sh $sid"
# done

# sketchybar --add item space_separator left                             \
#            --set space_separator icon="􀆊"                                \
#                                  icon.color=$ACCENT_COLOR \
#                                  icon.padding_left=4                   \
#                                  label.drawing=off                     \
#                                  background.drawing=off                \
#                                  script="$PLUGIN_DIR/space_windows.sh" \
#            --subscribe space_separator aerospace_workspace_change
