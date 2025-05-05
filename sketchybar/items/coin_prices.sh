#!/bin/bash


sketchybar --add item bitcoin left \
           --set bitcoin update_freq=300 \
                        script="$PLUGIN_DIR/coin_price.sh" \
                        icon='BTC' \
                        icon.padding_right=0 \
                        icon.color=$ACCENT_COLOR

sketchybar --add item solana left \
           --set solana update_freq=300 \
                        script="$PLUGIN_DIR/coin_price.sh" \
                        icon='SOL' \
                        icon.padding_right=0 \
                        icon.color=$ACCENT_COLOR

sketchybar --add item the-open-network left \
           --set the-open-network update_freq=300 \
                        script="$PLUGIN_DIR/coin_price.sh" \
                        icon='TON' \
                        icon.padding_right=0 \
                        icon.color=$ACCENT_COLOR

